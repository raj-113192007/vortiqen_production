"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.FeesService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
let FeesService = class FeesService {
    prisma;
    constructor(prisma) {
        this.prisma = prisma;
    }
    async createCategory(schoolId, name, amount) {
        return this.prisma.feeCategory.create({
            data: { schoolId, name, amount },
        });
    }
    async getCategories(schoolId) {
        return this.prisma.feeCategory.findMany({ where: { schoolId } });
    }
    async generateLedgers(schoolId, categoryId, dueDate, classId) {
        const whereClause = {
            schoolId,
            status: 'ENROLLED',
        };
        if (classId) {
            whereClause.classId = classId;
        }
        const students = await this.prisma.student.findMany({
            where: whereClause,
            include: { academicClass: true },
        });
        const category = await this.prisma.feeCategory.findUnique({
            where: { id: categoryId },
        });
        if (!category) {
            throw new common_1.NotFoundException('Fee category not found');
        }
        const isTuition = category.name.toLowerCase().includes('tuition');
        const ledgers = await this.prisma.$transaction(students.map((student) => {
            const classFee = student.academicClass?.monthlyFee;
            const amountDue = isTuition && classFee && classFee > 0 ? classFee : category.amount;
            return this.prisma.feeLedger.create({
                data: {
                    schoolId,
                    studentId: student.id,
                    categoryId,
                    dueDate: new Date(dueDate),
                    amountDue,
                },
            });
        }));
        return { success: true, count: ledgers.length };
    }
    async getLedgers(schoolId, classId, sectionId) {
        const whereClause = { schoolId };
        if (classId || sectionId) {
            whereClause.student = {};
            if (classId)
                whereClause.student.classId = classId;
            if (sectionId)
                whereClause.student.sectionId = sectionId;
        }
        return this.prisma.feeLedger.findMany({
            where: whereClause,
            include: {
                student: {
                    select: {
                        id: true,
                        rollNo: true,
                        firstName: true,
                        lastName: true,
                        user: { select: { name: true } },
                    },
                },
                category: true,
            },
            orderBy: { dueDate: 'asc' },
        });
    }
    async recordPayment(schoolId, ledgerId, amountPaid, paymentMethod, receiptNo) {
        const ledger = await this.prisma.feeLedger.findUnique({
            where: { id: ledgerId },
        });
        if (!ledger)
            throw new common_1.NotFoundException('Ledger not found');
        const newAmountPaid = ledger.amountPaid + amountPaid;
        let status = ledger.status;
        if (newAmountPaid >= ledger.amountDue) {
            status = 'PAID';
        }
        else if (newAmountPaid > 0) {
            status = 'PARTIAL';
        }
        return this.prisma.$transaction(async (prisma) => {
            const payment = await prisma.feePayment.create({
                data: {
                    schoolId,
                    ledgerId,
                    studentId: ledger.studentId,
                    amountPaid,
                    paymentMethod,
                    receiptNo,
                },
            });
            const updatedLedger = await prisma.feeLedger.update({
                where: { id: ledgerId },
                data: {
                    amountPaid: newAmountPaid,
                    status,
                },
            });
            return { payment, ledger: updatedLedger };
        });
    }
};
exports.FeesService = FeesService;
exports.FeesService = FeesService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], FeesService);
//# sourceMappingURL=fees.service.js.map
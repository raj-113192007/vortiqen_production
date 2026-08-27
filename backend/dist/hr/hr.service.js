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
exports.HrService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
let HrService = class HrService {
    prisma;
    constructor(prisma) {
        this.prisma = prisma;
    }
    async findAllEmployees(schoolId) {
        return this.prisma.employee.findMany({
            where: { schoolId },
            include: {
                user: {
                    select: { name: true, email: true, phone: true, role: true },
                },
            },
        });
    }
    async getMyEmployeeProfile(userId) {
        const employee = await this.prisma.employee.findUnique({
            where: { userId },
            include: {
                user: {
                    select: { name: true, email: true, phone: true, role: true },
                },
            },
        });
        if (!employee)
            throw new common_1.NotFoundException('Employee profile not found');
        return employee;
    }
    async createEmployee(schoolId, data) {
        const user = await this.prisma.user.findFirst({
            where: { id: data.userId, schoolId },
        });
        if (!user)
            throw new common_1.NotFoundException('User not found in this school');
        const existing = await this.prisma.employee.findUnique({
            where: { userId: data.userId },
        });
        if (existing)
            throw new common_1.BadRequestException('User already has an employee profile');
        return this.prisma.employee.create({
            data: {
                schoolId,
                userId: data.userId,
                designation: data.designation || '',
                department: data.department || '',
                baseSalary: data.baseSalary
                    ? parseFloat(data.baseSalary.toString())
                    : 0,
                joinDate: data.joinDate ? new Date(data.joinDate) : new Date(),
            },
        });
    }
    async findPayrolls(schoolId, month, year) {
        return this.prisma.payroll.findMany({
            where: { schoolId, month, year },
            include: {
                employee: {
                    include: {
                        user: {
                            select: { name: true },
                        },
                    },
                },
            },
        });
    }
    async getMyPayrolls(userId) {
        const employee = await this.prisma.employee.findUnique({
            where: { userId },
        });
        if (!employee)
            return [];
        return this.prisma.payroll.findMany({
            where: { employeeId: employee.id },
            orderBy: [{ year: 'desc' }, { month: 'desc' }],
            include: {
                employee: {
                    include: {
                        user: {
                            select: { name: true, role: true },
                        },
                    },
                },
            },
        });
    }
    async generatePayroll(schoolId, month, year) {
        const activeEmployees = await this.prisma.employee.findMany({
            where: { schoolId, status: 'ACTIVE' },
        });
        const generated = [];
        for (const emp of activeEmployees) {
            const existing = await this.prisma.payroll.findFirst({
                where: { schoolId, employeeId: emp.id, month, year },
            });
            if (existing)
                continue;
            const payroll = await this.prisma.payroll.create({
                data: {
                    schoolId,
                    employeeId: emp.id,
                    month,
                    year,
                    baseSalary: emp.baseSalary,
                    allowances: 0,
                    deductions: 0,
                    netPay: emp.baseSalary,
                    status: 'PENDING',
                },
            });
            generated.push(payroll);
        }
        return { generatedCount: generated.length, payrolls: generated };
    }
    async markAsPaid(schoolId, payrollId) {
        const payroll = await this.prisma.payroll.findFirst({
            where: { id: payrollId, schoolId },
        });
        if (!payroll)
            throw new common_1.NotFoundException('Payroll not found');
        if (payroll.status === 'PAID')
            throw new common_1.BadRequestException('Payroll is already marked as paid');
        return this.prisma.payroll.update({
            where: { id: payrollId },
            data: {
                status: 'PAID',
                paymentDate: new Date(),
            },
        });
    }
};
exports.HrService = HrService;
exports.HrService = HrService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], HrService);
//# sourceMappingURL=hr.service.js.map
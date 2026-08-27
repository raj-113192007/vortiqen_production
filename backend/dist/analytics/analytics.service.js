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
var AnalyticsService_1;
Object.defineProperty(exports, "__esModule", { value: true });
exports.AnalyticsService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
const schedule_1 = require("@nestjs/schedule");
let AnalyticsService = AnalyticsService_1 = class AnalyticsService {
    prisma;
    logger = new common_1.Logger(AnalyticsService_1.name);
    constructor(prisma) {
        this.prisma = prisma;
    }
    async getDashboardMetrics(schoolId) {
        const totalStudents = await this.prisma.student.count({
            where: { schoolId, status: 'ACTIVE' },
        });
        const totalTeachers = await this.prisma.user.count({
            where: { schoolId, role: 'TEACHER', status: 'ACTIVE' },
        });
        const fees = await this.prisma.feePayment.aggregate({
            where: { schoolId },
            _sum: { amountPaid: true },
        });
        const totalRevenue = fees._sum.amountPaid || 0;
        const pendingEnquiries = await this.prisma.admissionEnquiry.count({
            where: { schoolId, status: 'PENDING' },
        });
        const totalAssets = await this.prisma.asset.count({ where: { schoolId } });
        const assignedAssets = await this.prisma.asset.count({
            where: { schoolId, status: 'ASSIGNED' },
        });
        return {
            totalStudents,
            totalTeachers,
            totalRevenue,
            pendingEnquiries,
            totalAssets,
            assignedAssets,
        };
    }
    async getReports(schoolId) {
        return this.prisma.savedReport.findMany({
            where: { schoolId },
            orderBy: { createdAt: 'desc' },
        });
    }
    async handleMonthlyReports() {
        this.logger.log('Starting monthly report generation for all schools...');
        const schools = await this.prisma.school.findMany({
            where: { status: 'ACTIVE' },
        });
        for (const school of schools) {
            await this.generateMonthlyReport(school.id);
        }
    }
    async generateMonthlyReport(schoolId) {
        const metrics = await this.getDashboardMetrics(schoolId);
        const summary = `Monthly Summary:\nTotal Revenue generated: ₹${metrics.totalRevenue}.\nActive Students: ${metrics.totalStudents}.\nPending Admissions: ${metrics.pendingEnquiries}.\nAssets Assigned: ${metrics.assignedAssets}/${metrics.totalAssets}.`;
        return this.prisma.savedReport.create({
            data: {
                schoolId,
                type: 'MONTHLY_SUMMARY',
                month: new Date(new Date().getFullYear(), new Date().getMonth(), 1),
                summary,
                data: JSON.stringify(metrics),
            },
        });
    }
};
exports.AnalyticsService = AnalyticsService;
__decorate([
    (0, schedule_1.Cron)(schedule_1.CronExpression.EVERY_1ST_DAY_OF_MONTH_AT_MIDNIGHT),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], AnalyticsService.prototype, "handleMonthlyReports", null);
exports.AnalyticsService = AnalyticsService = AnalyticsService_1 = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], AnalyticsService);
//# sourceMappingURL=analytics.service.js.map
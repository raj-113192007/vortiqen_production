import { Injectable, Logger } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { Cron, CronExpression } from '@nestjs/schedule';

@Injectable()
export class AnalyticsService {
  private readonly logger = new Logger(AnalyticsService.name);

  constructor(private prisma: PrismaService) {}

  async getDashboardMetrics(schoolId: string) {
    const totalStudents = await this.prisma.student.count({ where: { schoolId, status: 'ACTIVE' } });
    const totalTeachers = await this.prisma.user.count({ where: { schoolId, role: 'TEACHER', status: 'ACTIVE' } });
    
    // Revenue logic (simple sum of paid fees)
    const fees = await this.prisma.feePayment.aggregate({
      where: { schoolId },
      _sum: { amountPaid: true },
    });
    const totalRevenue = fees._sum.amountPaid || 0;

    const pendingEnquiries = await this.prisma.admissionEnquiry.count({
      where: { schoolId, status: 'PENDING' }
    });

    const totalAssets = await this.prisma.asset.count({ where: { schoolId } });
    const assignedAssets = await this.prisma.asset.count({ where: { schoolId, status: 'ASSIGNED' } });

    return {
      totalStudents,
      totalTeachers,
      totalRevenue,
      pendingEnquiries,
      totalAssets,
      assignedAssets,
    };
  }

  async getReports(schoolId: string) {
    return this.prisma.savedReport.findMany({
      where: { schoolId },
      orderBy: { createdAt: 'desc' },
    });
  }

  // Monthly Cron Job to generate reports (Runs on the 1st of every month at midnight)
  @Cron(CronExpression.EVERY_1ST_DAY_OF_MONTH_AT_MIDNIGHT)
  async handleMonthlyReports() {
    this.logger.log('Starting monthly report generation for all schools...');
    const schools = await this.prisma.school.findMany({ where: { status: 'ACTIVE' } });

    for (const school of schools) {
      await this.generateMonthlyReport(school.id);
    }
  }

  async generateMonthlyReport(schoolId: string) {
    const metrics = await this.getDashboardMetrics(schoolId);
    
    // AI/Summary Generation Logic (Mocked for MVP)
    const summary = `Monthly Summary:\nTotal Revenue generated: ₹${metrics.totalRevenue}.\nActive Students: ${metrics.totalStudents}.\nPending Admissions: ${metrics.pendingEnquiries}.\nAssets Assigned: ${metrics.assignedAssets}/${metrics.totalAssets}.`;

    return this.prisma.savedReport.create({
      data: {
        schoolId,
        type: 'MONTHLY_SUMMARY',
        month: new Date(new Date().getFullYear(), new Date().getMonth(), 1), // 1st of current month
        summary,
        data: JSON.stringify(metrics),
      },
    });
  }
}

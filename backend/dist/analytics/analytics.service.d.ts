import { PrismaService } from '../prisma/prisma.service';
export declare class AnalyticsService {
    private prisma;
    private readonly logger;
    constructor(prisma: PrismaService);
    getDashboardMetrics(schoolId: string): Promise<{
        totalStudents: number;
        totalTeachers: number;
        totalRevenue: number;
        pendingEnquiries: number;
        totalAssets: number;
        assignedAssets: number;
    }>;
    getReports(schoolId: string): Promise<{
        id: string;
        schoolId: string;
        createdAt: Date;
        data: string;
        type: string;
        month: Date;
        summary: string;
    }[]>;
    handleMonthlyReports(): Promise<void>;
    generateMonthlyReport(schoolId: string): Promise<{
        id: string;
        schoolId: string;
        createdAt: Date;
        data: string;
        type: string;
        month: Date;
        summary: string;
    }>;
}

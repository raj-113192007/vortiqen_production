import { AnalyticsService } from './analytics.service';
import type { AuthenticatedRequest } from '../common/interfaces/authenticated-request.interface';
export declare class AnalyticsController {
    private readonly analyticsService;
    constructor(analyticsService: AnalyticsService);
    getDashboardMetrics(req: AuthenticatedRequest): Promise<{
        totalStudents: number;
        totalTeachers: number;
        totalRevenue: number;
        pendingEnquiries: number;
        totalAssets: number;
        assignedAssets: number;
    }>;
    getReports(req: AuthenticatedRequest): Promise<{
        id: string;
        schoolId: string;
        createdAt: Date;
        data: string;
        type: string;
        month: Date;
        summary: string;
    }[]>;
    generateReportNow(req: AuthenticatedRequest): Promise<{
        id: string;
        schoolId: string;
        createdAt: Date;
        data: string;
        type: string;
        month: Date;
        summary: string;
    }>;
}

import { Controller, Get, Post, UseGuards, Request } from '@nestjs/common';
import { AnalyticsService } from './analytics.service';
import { JwtAuthGuard } from '../common/guards/jwt-auth.guard';
import { RolesGuard } from '../common/guards/roles.guard';
import { Roles } from '../common/decorators/roles.decorator';
import type { AuthenticatedRequest } from '../common/interfaces/authenticated-request.interface';

@Controller('analytics')
@UseGuards(JwtAuthGuard, RolesGuard)
export class AnalyticsController {
  constructor(private readonly analyticsService: AnalyticsService) {}

  @Get('dashboard')
  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN', 'DIRECTOR')
  getDashboardMetrics(@Request() req: AuthenticatedRequest) {
    return this.analyticsService.getDashboardMetrics(
      req.user.schoolId as string,
    );
  }

  @Get('reports')
  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN', 'DIRECTOR')
  getReports(@Request() req: AuthenticatedRequest) {
    return this.analyticsService.getReports(req.user.schoolId as string);
  }

  @Post('reports/generate')
  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN', 'DIRECTOR')
  generateReportNow(@Request() req: AuthenticatedRequest) {
    return this.analyticsService.generateMonthlyReport(
      req.user.schoolId as string,
    );
  }
}

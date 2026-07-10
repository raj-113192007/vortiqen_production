import { Controller, Get, Post, Param, Body, UseGuards, Request } from '@nestjs/common';
import { AnalyticsService } from './analytics.service';
import { JwtAuthGuard } from '../common/guards/jwt-auth.guard';
import { RolesGuard } from '../common/guards/roles.guard';
import { Roles } from '../common/decorators/roles.decorator';

@Controller('analytics')
@UseGuards(JwtAuthGuard, RolesGuard)
export class AnalyticsController {
  constructor(private readonly analyticsService: AnalyticsService) {}

  @Get('dashboard')
  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN', 'DIRECTOR')
  getDashboardMetrics(@Request() req: any) {
    return this.analyticsService.getDashboardMetrics(req.user.schoolId);
  }

  @Get('reports')
  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN', 'DIRECTOR')
  getReports(@Request() req: any) {
    return this.analyticsService.getReports(req.user.schoolId);
  }

  @Post('reports/generate')
  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN', 'DIRECTOR')
  generateReportNow(@Request() req: any) {
    return this.analyticsService.generateMonthlyReport(req.user.schoolId);
  }
}

import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  UseGuards,
  Request,
  Query,
} from '@nestjs/common';
import { HrService } from './hr.service';
import { RolesGuard } from '../common/guards/roles.guard';
import { Roles } from '../common/decorators/roles.decorator';
import type { AuthenticatedRequest } from '../common/interfaces/authenticated-request.interface';

@Controller('hr')
export class HrController {
  constructor(private readonly hrService: HrService) {}

  @Get('employees')
  @UseGuards(RolesGuard)
  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN', 'DIRECTOR')
  findAllEmployees(@Request() req: AuthenticatedRequest) {
    return this.hrService.findAllEmployees(req.user.schoolId!);
  }

  @Get('employees/me')
  @UseGuards(RolesGuard)
  // Teachers, drivers, staff can view their own profile
  getMyEmployeeProfile(@Request() req: AuthenticatedRequest) {
    return this.hrService.getMyEmployeeProfile(req.user.userId);
  }

  @Post('employees')
  @UseGuards(RolesGuard)
  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN', 'DIRECTOR')
  createEmployee(
    @Request() req: AuthenticatedRequest,
    @Body()
    createEmployeeDto: {
      userId: string;
      designation?: string;
      department?: string;
      baseSalary?: string | number;
      joinDate?: string | Date;
    },
  ) {
    return this.hrService.createEmployee(req.user.schoolId!, createEmployeeDto);
  }

  @Get('payroll')
  @UseGuards(RolesGuard)
  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN', 'DIRECTOR')
  findPayrolls(
    @Request() req: AuthenticatedRequest,
    @Query('month') month: string,
    @Query('year') year: string,
  ) {
    return this.hrService.findPayrolls(
      req.user.schoolId!,
      month ? parseInt(month, 10) : new Date().getMonth() + 1,
      year ? parseInt(year, 10) : new Date().getFullYear(),
    );
  }

  @Get('payroll/me')
  @UseGuards(RolesGuard)
  getMyPayrolls(@Request() req: AuthenticatedRequest) {
    return this.hrService.getMyPayrolls(req.user.userId);
  }

  @Post('payroll/generate')
  @UseGuards(RolesGuard)
  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN', 'DIRECTOR')
  generatePayroll(
    @Request() req: AuthenticatedRequest,
    @Body() data: { month: number; year: number },
  ) {
    return this.hrService.generatePayroll(
      req.user.schoolId!,
      data.month,
      data.year,
    );
  }

  @Patch('payroll/:id/pay')
  @UseGuards(RolesGuard)
  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN', 'DIRECTOR')
  markAsPaid(@Request() req: AuthenticatedRequest, @Param('id') id: string) {
    return this.hrService.markAsPaid(req.user.schoolId!, id);
  }
}

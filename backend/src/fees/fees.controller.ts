import { Controller, Get, Post, Body, Query, UseGuards } from '@nestjs/common';
import { FeesService } from './fees.service';
import { JwtAuthGuard } from '../common/guards/jwt-auth.guard';
import { RolesGuard } from '../common/guards/roles.guard';
import { Roles } from '../common/decorators/roles.decorator';
import { SchoolId } from '../common/decorators/school-id.decorator';

@UseGuards(JwtAuthGuard, RolesGuard)
@Controller('api/v1/fees')
export class FeesController {
  constructor(private readonly feesService: FeesService) {}

  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN')
  @Post('categories')
  async createCategory(
    @SchoolId() schoolId: string,
    @Body() body: { name: string; amount: number }
  ) {
    return this.feesService.createCategory(schoolId, body.name, body.amount);
  }

  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN', 'PARENT', 'STUDENT')
  @Get('categories')
  async getCategories(@SchoolId() schoolId: string) {
    return this.feesService.getCategories(schoolId);
  }

  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN')
  @Post('ledgers/generate')
  async generateLedgers(
    @SchoolId() schoolId: string,
    @Body() body: { categoryId: string; dueDate: string; classId?: string }
  ) {
    return this.feesService.generateLedgers(schoolId, body.categoryId, body.dueDate, body.classId);
  }

  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN', 'PARENT', 'STUDENT')
  @Get('ledgers')
  async getLedgers(
    @SchoolId() schoolId: string,
    @Query('classId') classId?: string,
    @Query('sectionId') sectionId?: string,
  ) {
    return this.feesService.getLedgers(schoolId, classId, sectionId);
  }

  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN')
  @Post('pay')
  async recordPayment(
    @SchoolId() schoolId: string,
    @Body() body: { ledgerId: string; amountPaid: number; paymentMethod: string; receiptNo?: string }
  ) {
    return this.feesService.recordPayment(schoolId, body.ledgerId, body.amountPaid, body.paymentMethod, body.receiptNo);
  }
}

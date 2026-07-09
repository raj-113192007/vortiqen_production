import { Controller, Get, Patch, Param, Body, UseGuards } from '@nestjs/common';
import { SuperadminService } from './superadmin.service';
import { RolesGuard } from '../common/guards/roles.guard';
import { Roles } from '../common/decorators/roles.decorator';

@Controller('superadmin')
@UseGuards(RolesGuard)
@Roles('SUPER_ADMIN')
export class SuperadminController {
  constructor(private readonly superadminService: SuperadminService) {}

  @Get('stats')
  getStats() {
    return this.superadminService.getStats();
  }

  @Get('schools')
  getAllSchools() {
    return this.superadminService.getAllSchools();
  }

  @Patch('schools/:id/status')
  updateSchoolStatus(@Param('id') id: string, @Body('status') status: string) {
    return this.superadminService.updateSchoolStatus(id, status);
  }
}

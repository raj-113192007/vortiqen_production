import { Controller, Get, Post, Body, Patch, Param, UseGuards, Request, Query } from '@nestjs/common';
import { AdmissionsService } from './admissions.service';
import { CreateEnquiryDto } from './dto/create-enquiry.dto';
import { UpdateEnquiryDto } from './dto/update-enquiry.dto';
import { JwtAuthGuard } from '../common/guards/jwt-auth.guard';
import { RolesGuard } from '../common/guards/roles.guard';
import { Roles } from '../common/decorators/roles.decorator';

@Controller('admissions')
export class AdmissionsController {
  constructor(private readonly admissionsService: AdmissionsService) {}

  // Public endpoint for external website
  @Post('public/enquiry')
  createPublicEnquiry(@Body() createEnquiryDto: CreateEnquiryDto) {
    if (!createEnquiryDto.schoolId) {
      return { success: false, message: 'schoolId is required for public enquiry' };
    }
    return this.admissionsService.createEnquiry(createEnquiryDto);
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles('SCHOOL_ADMIN', 'SUPER_ADMIN')
  @Post('enquiry')
  createEnquiry(@Request() req: any, @Body() createEnquiryDto: CreateEnquiryDto) {
    return this.admissionsService.createEnquiry(createEnquiryDto, req.user.schoolId);
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles('SCHOOL_ADMIN', 'SUPER_ADMIN')
  @Get('enquiries')
  findAll(@Request() req: any, @Query('status') status?: string) {
    return this.admissionsService.findAllBySchool(req.user.schoolId, status);
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles('SCHOOL_ADMIN', 'SUPER_ADMIN')
  @Get('enquiry/:id')
  findOne(@Request() req: any, @Param('id') id: string) {
    return this.admissionsService.findOne(id, req.user.schoolId);
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles('SCHOOL_ADMIN', 'SUPER_ADMIN')
  @Patch('enquiry/:id')
  update(@Request() req: any, @Param('id') id: string, @Body() updateEnquiryDto: UpdateEnquiryDto) {
    return this.admissionsService.update(id, req.user.schoolId, updateEnquiryDto);
  }
}

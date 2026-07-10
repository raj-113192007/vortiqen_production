import { Controller, Get, Post, Patch, Body, Param, UseGuards, Request } from '@nestjs/common';
import { CctvService } from './cctv.service';
import { JwtAuthGuard } from '../common/guards/jwt-auth.guard';
import { RolesGuard } from '../common/guards/roles.guard';
import { Roles } from '../common/decorators/roles.decorator';

@Controller('cctv')
@UseGuards(JwtAuthGuard, RolesGuard)
export class CctvController {
  constructor(private readonly cctvService: CctvService) {}

  @Get()
  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN', 'DIRECTOR')
  getAllCameras(@Request() req: any) {
    return this.cctvService.getAllCameras(req.user.schoolId);
  }

  @Post()
  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN')
  addCamera(@Request() req: any, @Body() data: any) {
    return this.cctvService.addCamera(req.user.schoolId, data);
  }

  @Patch(':id')
  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN')
  updateCamera(@Param('id') id: string, @Request() req: any, @Body() data: any) {
    return this.cctvService.updateCamera(id, req.user.schoolId, data);
  }
}

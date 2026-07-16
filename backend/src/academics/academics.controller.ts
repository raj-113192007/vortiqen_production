import {
  Controller,
  Post,
  Get,
  Body,
  UseGuards,
  Request,
} from '@nestjs/common';
import { AcademicsService } from './academics.service';
import { CreateClassDto } from './dto/create-class.dto';
import { JwtAuthGuard } from '../common/guards/jwt-auth.guard';
import { SchoolScopeGuard } from '../common/guards/school-scope.guard';
import type { AuthenticatedRequest } from '../common/interfaces/authenticated-request.interface';

@Controller('api/v1/classes')
@UseGuards(JwtAuthGuard, SchoolScopeGuard)
export class AcademicsController {
  constructor(private readonly academicsService: AcademicsService) {}

  @Post()
  async createClass(
    @Body() createDto: CreateClassDto,
    @Request() req: AuthenticatedRequest,
  ) {
    const data = await this.academicsService.createClass(
      req.user.schoolId!,
      createDto,
    );
    return { success: true, data };
  }

  @Get()
  async getClasses(@Request() req: AuthenticatedRequest) {
    const data = await this.academicsService.getClasses(req.user.schoolId!);
    return { success: true, data };
  }
}

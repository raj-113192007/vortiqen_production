import {
  Controller,
  Get,
  Post,
  Body,
  Param,
  UseGuards,
  Request,
} from '@nestjs/common';
import { TransportService } from './transport.service';
import {
  CreateRouteDto,
  CreateVehicleDto,
  AssignStudentTransportDto,
} from './dto/create-transport.dto';
import { RolesGuard } from '../common/guards/roles.guard';
import { Roles } from '../common/decorators/roles.decorator';
import type { AuthenticatedRequest } from '../common/interfaces/authenticated-request.interface';

@Controller('transport')
@UseGuards(RolesGuard)
export class TransportController {
  constructor(private readonly transportService: TransportService) {}

  @Post('routes')
  @Roles('SCHOOL_ADMIN')
  createRoute(
    @Body() dto: CreateRouteDto,
    @Request() req: AuthenticatedRequest,
  ) {
    return this.transportService.createRoute(dto, req.user.schoolId!);
  }

  @Get('routes')
  @Roles('SCHOOL_ADMIN', 'TEACHER', 'DRIVER')
  getRoutes(@Request() req: AuthenticatedRequest) {
    return this.transportService.getRoutes(req.user.schoolId!);
  }

  @Post('vehicles')
  @Roles('SCHOOL_ADMIN')
  createVehicle(
    @Body() dto: CreateVehicleDto,
    @Request() req: AuthenticatedRequest,
  ) {
    return this.transportService.createVehicle(dto, req.user.schoolId!);
  }

  @Get('vehicles')
  @Roles('SCHOOL_ADMIN', 'TEACHER', 'DRIVER')
  getVehicles(@Request() req: AuthenticatedRequest) {
    return this.transportService.getVehicles(req.user.schoolId!);
  }

  @Post('assign')
  @Roles('SCHOOL_ADMIN')
  assignStudent(
    @Body() dto: AssignStudentTransportDto,
    @Request() req: AuthenticatedRequest,
  ) {
    return this.transportService.assignStudent(dto, req.user.schoolId!);
  }

  @Get('student/:studentId')
  @Roles('SCHOOL_ADMIN', 'TEACHER', 'STUDENT', 'PARENT')
  getStudentTransportDetails(
    @Param('studentId') studentId: string,
    @Request() req: AuthenticatedRequest,
  ) {
    return this.transportService.getStudentTransportDetails(
      studentId,
      req.user.schoolId!,
    );
  }

  @Get('driver/my-details')
  @Roles('DRIVER')
  getDriverTransportDetails(@Request() req: AuthenticatedRequest) {
    return this.transportService.getDriverTransportDetails(
      req.user.userId,
      req.user.schoolId!,
    );
  }
}

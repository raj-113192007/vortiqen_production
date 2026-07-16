import { Controller, Get, Post, Body, Query, UseGuards } from '@nestjs/common';
import { AttendanceService } from './attendance.service';
import { JwtAuthGuard } from '../common/guards/jwt-auth.guard';
import { RolesGuard } from '../common/guards/roles.guard';
import { Roles } from '../common/decorators/roles.decorator';
import { SchoolId } from '../common/decorators/school-id.decorator';

@UseGuards(JwtAuthGuard, RolesGuard)
@Controller('api/v1/attendance')
export class AttendanceController {
  constructor(private readonly attendanceService: AttendanceService) {}

  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN', 'TEACHER')
  @Post()
  async markAttendance(
    @SchoolId() schoolId: string,
    @Body()
    body: {
      date: string;
      studentStatuses: {
        studentId: string;
        status: string;
        remarks?: string;
      }[];
      markedById: string;
    },
  ) {
    return this.attendanceService.markAttendance(
      schoolId,
      body.date,
      body.studentStatuses,
      body.markedById,
    );
  }

  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN', 'TEACHER')
  @Get('class')
  async getAttendanceByClass(
    @SchoolId() schoolId: string,
    @Query('classId') classId: string,
    @Query('sectionId') sectionId: string,
    @Query('date') date: string,
  ) {
    return this.attendanceService.getAttendanceByClass(
      schoolId,
      classId,
      sectionId,
      date,
    );
  }

  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN', 'TEACHER', 'PARENT', 'STUDENT')
  @Get('student')
  async getAttendanceByStudent(
    @SchoolId() schoolId: string,
    @Query('studentId') studentId: string,
  ) {
    return this.attendanceService.getAttendanceByStudent(schoolId, studentId);
  }
}

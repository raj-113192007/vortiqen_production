import { Controller, Get, Post, Body, Param, UseGuards, Query } from '@nestjs/common';
import { StudentsService } from './students.service';
import { JwtAuthGuard } from '../common/guards/jwt-auth.guard';
import { RolesGuard } from '../common/guards/roles.guard';
import { Roles } from '../common/decorators/roles.decorator';

@UseGuards(JwtAuthGuard, RolesGuard)
@Controller('students')
export class StudentsController {
  constructor(private readonly studentsService: StudentsService) {}

  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN', 'DIRECTOR')
  @Post()
  create(@Body() createStudentDto: any) {
    return this.studentsService.create(createStudentDto);
  }

  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN', 'DIRECTOR', 'TEACHER', 'PARENT', 'STUDENT')
  @Get()
  findAll(
    @Query('schoolId') schoolId: string, 
    @Query('classId') classId?: string,
    @Query('sectionId') sectionId?: string,
    @Query('parentId') parentId?: string,
    @Query('userId') userId?: string,
  ) {
    return this.studentsService.findAll(schoolId, classId, sectionId, parentId, userId);
  }

  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN', 'DIRECTOR', 'TEACHER', 'STUDENT', 'PARENT')
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.studentsService.findOne(id);
  }
}

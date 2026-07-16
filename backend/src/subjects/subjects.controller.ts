import {
  Controller,
  Get,
  Post,
  Body,
  Param,
  Delete,
  UseGuards,
  Query,
} from '@nestjs/common';
import { SubjectsService } from './subjects.service';
import { JwtAuthGuard } from '../common/guards/jwt-auth.guard';
import { RolesGuard } from '../common/guards/roles.guard';
import { Roles } from '../common/decorators/roles.decorator';
import { Prisma } from '@prisma/client';

@UseGuards(JwtAuthGuard, RolesGuard)
@Controller('subjects')
export class SubjectsController {
  constructor(private readonly subjectsService: SubjectsService) {}

  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN', 'DIRECTOR')
  @Post()
  create(@Body() createSubjectDto: Prisma.SubjectUncheckedCreateInput) {
    return this.subjectsService.create(createSubjectDto);
  }

  @Roles(
    'SUPER_ADMIN',
    'SCHOOL_ADMIN',
    'DIRECTOR',
    'TEACHER',
    'STUDENT',
    'PARENT',
  )
  @Get()
  findAll(
    @Query('schoolId') schoolId: string,
    @Query('classId') classId?: string,
  ) {
    return this.subjectsService.findAll(schoolId, classId);
  }

  @Roles(
    'SUPER_ADMIN',
    'SCHOOL_ADMIN',
    'DIRECTOR',
    'TEACHER',
    'STUDENT',
    'PARENT',
  )
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.subjectsService.findOne(id);
  }

  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN', 'DIRECTOR')
  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.subjectsService.remove(id);
  }
}

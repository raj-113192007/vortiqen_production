import {
  Controller,
  Get,
  Post,
  Body,
  Param,
  UseGuards,
  Request,
} from '@nestjs/common';
import { ExamsService } from './exams.service';
import {
  CreateExamDto,
  AddExamSubjectDto,
  BulkSubmitExamResultsDto,
} from './dto/create-exam.dto';
import { RolesGuard } from '../common/guards/roles.guard';
import { Roles } from '../common/decorators/roles.decorator';
import type { AuthenticatedRequest } from '../common/interfaces/authenticated-request.interface';

@Controller('exams')
@UseGuards(RolesGuard)
export class ExamsController {
  constructor(private readonly examsService: ExamsService) {}

  @Post()
  @Roles('SCHOOL_ADMIN', 'TEACHER')
  create(
    @Body() createExamDto: CreateExamDto,
    @Request() req: AuthenticatedRequest,
  ) {
    return this.examsService.create(createExamDto, req.user.schoolId!);
  }

  @Get()
  @Roles('SCHOOL_ADMIN', 'TEACHER', 'STUDENT', 'PARENT')
  findAll(@Request() req: AuthenticatedRequest) {
    return this.examsService.findAllBySchool(req.user.schoolId!);
  }

  @Get(':id')
  @Roles('SCHOOL_ADMIN', 'TEACHER', 'STUDENT', 'PARENT')
  findOne(@Param('id') id: string, @Request() req: AuthenticatedRequest) {
    return this.examsService.findOne(id, req.user.schoolId!);
  }

  @Post(':id/subjects')
  @Roles('SCHOOL_ADMIN', 'TEACHER')
  addExamSubject(
    @Param('id') id: string,
    @Body() dto: AddExamSubjectDto,
    @Request() req: AuthenticatedRequest,
  ) {
    return this.examsService.addExamSubject(id, dto, req.user.schoolId!);
  }

  @Post('subjects/:subjectId/marks')
  @Roles('TEACHER', 'SCHOOL_ADMIN')
  bulkSubmitResults(
    @Param('subjectId') subjectId: string,
    @Body() dto: BulkSubmitExamResultsDto,
    @Request() req: AuthenticatedRequest,
  ) {
    return this.examsService.bulkSubmitResults(
      subjectId,
      dto,
      req.user.schoolId!,
    );
  }

  @Get('student/:studentId/report-card')
  @Roles('SCHOOL_ADMIN', 'TEACHER', 'STUDENT', 'PARENT')
  getStudentReportCard(
    @Param('studentId') studentId: string,
    @Request() req: AuthenticatedRequest,
  ) {
    // Note: If role is STUDENT or PARENT, they should only be able to query their own ID.
    // For MVP, we trust the client or could add logic here.
    return this.examsService.getStudentReportCard(studentId, req.user.schoolId!);
  }
}

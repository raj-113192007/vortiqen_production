import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  UseGuards,
  Request,
  UseInterceptors,
  UploadedFile,
} from '@nestjs/common';
import { AssignmentsService } from './assignments.service';
import { CreateAssignmentDto } from './dto/create-assignment.dto';
import { RolesGuard } from '../common/guards/roles.guard';
import { Roles } from '../common/decorators/roles.decorator';
import { FileInterceptor } from '@nestjs/platform-express';
import { diskStorage } from 'multer';
import { extname } from 'path';
import type { AuthenticatedRequest } from '../common/interfaces/authenticated-request.interface';

const storage = diskStorage({
  destination: './uploads/assignments',
  filename: (req, file, cb) => {
    const randomName = Array(32)
      .fill(null)
      .map(() => Math.round(Math.random() * 16).toString(16))
      .join('');
    cb(null, `${randomName}${extname(file.originalname)}`);
  },
});

@Controller('assignments')
@UseGuards(RolesGuard)
export class AssignmentsController {
  constructor(private readonly assignmentsService: AssignmentsService) {}

  @Post()
  @Roles('TEACHER')
  @UseInterceptors(FileInterceptor('file', { storage }))
  create(
    @Body() createAssignmentDto: CreateAssignmentDto,
    @Request() req: AuthenticatedRequest,
    @UploadedFile() file?: Express.Multer.File,
  ) {
    const attachmentUrl = file
      ? `/uploads/assignments/${file.filename}`
      : undefined;
    return this.assignmentsService.create(
      createAssignmentDto,
      req.user.schoolId as string,
      req.user.userId,
      attachmentUrl,
    );
  }

  @Get('section/:sectionId')
  @Roles('TEACHER', 'STUDENT', 'PARENT')
  findAllBySection(
    @Param('sectionId') sectionId: string,
    @Request() req: AuthenticatedRequest,
  ) {
    return this.assignmentsService.findAllBySection(
      sectionId,
      req.user.schoolId as string,
    );
  }

  @Get('teacher')
  @Roles('TEACHER')
  findAllByTeacher(@Request() req: AuthenticatedRequest) {
    return this.assignmentsService.findAllByTeacher(
      req.user.userId,
      req.user.schoolId as string,
    );
  }

  @Post(':id/submit')
  @Roles('STUDENT', 'PARENT')
  @UseInterceptors(FileInterceptor('file', { storage }))
  submitAssignment(
    @Param('id') id: string,
    @Body('studentId') studentId: string,
    @Body('content') content?: string,
    @UploadedFile() file?: Express.Multer.File,
  ) {
    const attachmentUrl = file
      ? `/uploads/assignments/${file.filename}`
      : undefined;
    return this.assignmentsService.submitAssignment(
      id,
      studentId,
      content,
      attachmentUrl,
    );
  }

  @Get(':id/submissions')
  @Roles('TEACHER', 'SCHOOL_ADMIN')
  getSubmissions(
    @Param('id') id: string,
    @Request() req: AuthenticatedRequest,
  ) {
    return this.assignmentsService.getSubmissions(
      id,
      req.user.schoolId as string,
    );
  }

  @Patch('submissions/:submissionId/grade')
  @Roles('TEACHER')
  gradeSubmission(
    @Param('submissionId') submissionId: string,
    @Body('grade') grade: string,
    @Body('teacherNotes') teacherNotes?: string,
  ) {
    return this.assignmentsService.gradeSubmission(
      submissionId,
      grade,
      teacherNotes,
    );
  }
}

import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateAssignmentDto } from './dto/create-assignment.dto';

@Injectable()
export class AssignmentsService {
  constructor(private prisma: PrismaService) {}

  async create(createAssignmentDto: CreateAssignmentDto, schoolId: string, teacherId: string, attachmentUrl?: string) {
    return this.prisma.assignment.create({
      data: {
        schoolId,
        teacherId,
        sectionId: createAssignmentDto.sectionId,
        subjectId: createAssignmentDto.subjectId,
        title: createAssignmentDto.title,
        description: createAssignmentDto.description,
        dueDate: new Date(createAssignmentDto.dueDate),
        attachmentUrl,
      },
    });
  }

  async findAllBySection(sectionId: string, schoolId: string) {
    return this.prisma.assignment.findMany({
      where: { sectionId, schoolId },
      include: {
        subject: { select: { name: true } },
        teacher: { select: { name: true } },
      },
      orderBy: { createdAt: 'desc' },
    });
  }

  async findAllByTeacher(teacherId: string, schoolId: string) {
    return this.prisma.assignment.findMany({
      where: { teacherId, schoolId },
      include: {
        section: { select: { name: true, academicClass: { select: { name: true } } } },
        subject: { select: { name: true } },
      },
      orderBy: { createdAt: 'desc' },
    });
  }

  async submitAssignment(assignmentId: string, studentId: string, content?: string, attachmentUrl?: string) {
    return this.prisma.assignmentSubmission.upsert({
      where: {
        assignmentId_studentId: { assignmentId, studentId },
      },
      update: {
        content,
        attachmentUrl,
        status: 'SUBMITTED',
      },
      create: {
        assignmentId,
        studentId,
        content,
        attachmentUrl,
        status: 'SUBMITTED',
      },
    });
  }

  async getSubmissions(assignmentId: string, schoolId: string) {
    // Verify assignment belongs to school
    const assignment = await this.prisma.assignment.findUnique({
      where: { id: assignmentId, schoolId },
    });
    if (!assignment) throw new NotFoundException('Assignment not found');

    return this.prisma.assignmentSubmission.findMany({
      where: { assignmentId },
      include: {
        student: { select: { id: true, firstName: true, lastName: true, rollNo: true } },
      },
    });
  }

  async gradeSubmission(submissionId: string, grade: string, teacherNotes?: string) {
    return this.prisma.assignmentSubmission.update({
      where: { id: submissionId },
      data: {
        grade,
        teacherNotes,
        status: 'GRADED',
      },
    });
  }
}

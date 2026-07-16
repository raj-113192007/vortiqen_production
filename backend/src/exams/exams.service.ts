import { Injectable, NotFoundException } from '@nestjs/common';
import {
  CreateExamDto,
  AddExamSubjectDto,
  BulkSubmitExamResultsDto,
} from './dto/create-exam.dto';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class ExamsService {
  constructor(private prisma: PrismaService) {}

  async create(createExamDto: CreateExamDto, schoolId: string) {
    return this.prisma.exam.create({
      data: {
        schoolId,
        classId: createExamDto.classId,
        name: createExamDto.name,
        startDate: createExamDto.startDate
          ? new Date(createExamDto.startDate)
          : undefined,
        endDate: createExamDto.endDate
          ? new Date(createExamDto.endDate)
          : undefined,
      },
      include: {
        academicClass: true,
      },
    });
  }

  async findAllBySchool(schoolId: string) {
    return this.prisma.exam.findMany({
      where: { schoolId },
      include: {
        academicClass: true,
        examSubjects: {
          include: {
            subject: true,
          },
        },
      },
      orderBy: { createdAt: 'desc' },
    });
  }

  async findOne(id: string, schoolId: string) {
    const exam = await this.prisma.exam.findFirst({
      where: { id, schoolId },
      include: {
        academicClass: {
          include: {
            sections: true,
          },
        },
        examSubjects: {
          include: {
            subject: true,
            examResults: {
              include: {
                student: true,
              },
            },
          },
        },
      },
    });

    if (!exam) throw new NotFoundException('Exam not found');
    return exam;
  }

  async addExamSubject(
    examId: string,
    dto: AddExamSubjectDto,
    schoolId: string,
  ) {
    // Verify exam belongs to school
    await this.findOne(examId, schoolId);

    return this.prisma.examSubject.create({
      data: {
        examId,
        subjectId: dto.subjectId,
        examDate: dto.examDate ? new Date(dto.examDate) : undefined,
        maxMarks: dto.maxMarks,
      },
      include: {
        subject: true,
      },
    });
  }

  async bulkSubmitResults(
    examSubjectId: string,
    dto: BulkSubmitExamResultsDto,
    schoolId: string,
  ) {
    // Verify examSubject belongs to an exam in the school
    const examSubject = await this.prisma.examSubject.findUnique({
      where: { id: examSubjectId },
      include: { exam: true },
    });

    if (!examSubject || examSubject.exam.schoolId !== schoolId) {
      throw new NotFoundException('Exam Subject not found');
    }

    const results = [];
    for (const res of dto.results) {
      const result = await this.prisma.examResult.upsert({
        where: {
          examSubjectId_studentId: {
            examSubjectId,
            studentId: res.studentId,
          },
        },
        update: {
          marksObtained: res.marksObtained,
          grade: res.grade,
          remarks: res.remarks,
        },
        create: {
          examSubjectId,
          studentId: res.studentId,
          marksObtained: res.marksObtained,
          grade: res.grade,
          remarks: res.remarks,
        },
      });
      results.push(result);
    }
    return results;
  }

  async getStudentReportCard(studentId: string, schoolId: string) {
    // Get all exam results for the student grouped by exam
    const student = await this.prisma.student.findFirst({
      where: { id: studentId, schoolId },
    });

    if (!student) throw new NotFoundException('Student not found');

    const results = await this.prisma.examResult.findMany({
      where: { studentId },
      include: {
        examSubject: {
          include: {
            exam: true,
            subject: true,
          },
        },
      },
    });

    // Group by Exam ID
    const examsMap = new Map<
      string,
      {
        id: string;
        name: string;
        startDate: Date | null;
        endDate: Date | null;
        status: string;
        subjects: {
          subjectName: string;
          maxMarks: number;
          examDate: Date | null;
          marksObtained: number | null;
          grade: string | null;
          remarks: string | null;
        }[];
      }
    >();

    for (const res of results) {
      const exam = res.examSubject.exam;
      if (!examsMap.has(exam.id)) {
        examsMap.set(exam.id, {
          id: exam.id,
          name: exam.name,
          startDate: exam.startDate,
          endDate: exam.endDate,
          status: exam.status,
          subjects: [],
        });
      }

      examsMap.get(exam.id)!.subjects.push({
        subjectName: res.examSubject.subject.name,
        maxMarks: res.examSubject.maxMarks,
        examDate: res.examSubject.examDate,
        marksObtained: res.marksObtained,
        grade: res.grade,
        remarks: res.remarks,
      });
    }

    return Array.from(examsMap.values());
  }
}

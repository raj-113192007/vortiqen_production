import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class AttendanceService {
  constructor(private prisma: PrismaService) {}

  async markAttendance(
    schoolId: string,
    date: string,
    studentStatuses: { studentId: string; status: string; remarks?: string }[],
    markedById: string,
  ) {
    const attendanceDate = new Date(date);
    attendanceDate.setUTCHours(0, 0, 0, 0); // Normalize to start of day

    // We can use a transaction to upsert attendance for all students
    const results = await this.prisma.$transaction(
      studentStatuses.map((ss) =>
        this.prisma.attendance.upsert({
          where: {
            studentId_date: {
              studentId: ss.studentId,
              date: attendanceDate,
            },
          },
          update: {
            status: ss.status,
            remarks: ss.remarks,
            markedById,
          },
          create: {
            schoolId,
            studentId: ss.studentId,
            date: attendanceDate,
            status: ss.status,
            remarks: ss.remarks,
            markedById,
          },
        }),
      ),
    );

    return { success: true, count: results.length };
  }

  async getAttendanceByClass(
    schoolId: string,
    classId: string,
    sectionId: string,
    date: string,
  ) {
    const attendanceDate = new Date(date);
    attendanceDate.setUTCHours(0, 0, 0, 0);

    return this.prisma.attendance.findMany({
      where: {
        schoolId,
        date: attendanceDate,
        student: {
          classId,
          sectionId,
        },
      },
      include: {
        student: {
          select: {
            id: true,
            rollNo: true,
            firstName: true,
            lastName: true,
          },
        },
      },
    });
  }

  async getAttendanceByStudent(schoolId: string, studentId: string) {
    return this.prisma.attendance.findMany({
      where: { schoolId, studentId },
      orderBy: { date: 'desc' },
      take: 30, // Last 30 days
    });
  }
}

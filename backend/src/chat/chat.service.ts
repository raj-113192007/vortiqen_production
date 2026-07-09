import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class ChatService {
  constructor(private prisma: PrismaService) {}

  async getStudentContacts(studentUserId: string, schoolId: string) {
    // 1. Get the student's class
    const student = await this.prisma.student.findUnique({
      where: { userId: studentUserId }
    });

    if (!student || !student.classId) return [];

    // 2. Find all subjects in that class
    const subjects = await this.prisma.subject.findMany({
      where: { classId: student.classId, schoolId, teacherId: { not: null } },
      include: { teacher: true }
    });

    // 3. Return unique teachers
    const teachersMap = new Map();
    for (const sub of subjects) {
      if (sub.teacher && !teachersMap.has(sub.teacher.id)) {
        teachersMap.set(sub.teacher.id, {
          id: sub.teacher.id,
          name: sub.teacher.name,
          role: sub.teacher.role,
        });
      }
    }
    return Array.from(teachersMap.values());
  }

  async getTeacherContacts(teacherUserId: string, schoolId: string) {
    // 1. Find all subjects taught by this teacher
    const subjects = await this.prisma.subject.findMany({
      where: { teacherId: teacherUserId, schoolId },
    });

    const classIds = subjects.map(s => s.classId);

    // 2. Find all students in those classes
    const students = await this.prisma.student.findMany({
      where: {
        classId: { in: classIds },
        schoolId,
        userId: { not: null }
      },
      include: { user: true, academicClass: true }
    });

    const studentContactsMap = new Map();
    for (const st of students) {
      if (st.user && !studentContactsMap.has(st.user.id)) {
        studentContactsMap.set(st.user.id, {
          id: st.user.id,
          name: `${st.firstName} ${st.lastName ?? ''}`.trim(),
          role: 'STUDENT',
          details: `Class: ${st.academicClass?.name ?? ''} | Roll: ${st.rollNo}`,
        });
      }
    }
    return Array.from(studentContactsMap.values());
  }

  async saveMessage(schoolId: string, senderId: string, receiverId: string, content: string) {
    return this.prisma.message.create({
      data: {
        schoolId,
        senderId,
        receiverId,
        content,
      }
    });
  }

  async getChatHistory(schoolId: string, userId: string, otherUserId: string) {
    return this.prisma.message.findMany({
      where: {
        schoolId,
        OR: [
          { senderId: userId, receiverId: otherUserId },
          { senderId: otherUserId, receiverId: userId }
        ]
      },
      orderBy: { createdAt: 'asc' }
    });
  }
}

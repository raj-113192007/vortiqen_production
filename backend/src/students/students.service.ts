import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import * as bcrypt from 'bcrypt';
import { Prisma } from '@prisma/client';

@Injectable()
export class StudentsService {
  constructor(private prisma: PrismaService) {}

  async create(createStudentDto: {
    schoolId: string;
    studentUsername: string;
    firstName: string;
    lastName?: string;
    password?: string;
    parentUsername: string;
    classId: string;
    sectionId: string;
    rollNo?: string;
    gender?: string;
  }) {
    // 1. Create User account for Student
    const studentUser = await this.prisma.user.create({
      data: {
        schoolId: createStudentDto.schoolId,
        username: createStudentDto.studentUsername,
        name: `${createStudentDto.firstName} ${createStudentDto.lastName || ''}`.trim(),
        password: await bcrypt.hash(
          createStudentDto.password || 'Student@123',
          10,
        ),
        role: 'STUDENT',
      },
    });

    // 2. Create User account for Parent
    const parentUser = await this.prisma.user.create({
      data: {
        schoolId: createStudentDto.schoolId,
        username: createStudentDto.parentUsername,
        name: `${createStudentDto.firstName}'s Parent`,
        password: await bcrypt.hash(
          createStudentDto.password || 'Parent@123',
          10,
        ),
        role: 'PARENT',
      },
    });

    // 3. Create Student profile
    return this.prisma.student.create({
      data: {
        schoolId: createStudentDto.schoolId,
        classId: createStudentDto.classId,
        sectionId: createStudentDto.sectionId,
        userId: studentUser.id,
        parentId: parentUser.id,
        rollNo: createStudentDto.rollNo,
        firstName: createStudentDto.firstName,
        lastName: createStudentDto.lastName,
        gender: createStudentDto.gender,
      },
      include: {
        user: { select: { id: true, username: true } },
        parent: { select: { id: true, username: true } },
        academicClass: { select: { id: true, name: true } },
        section: { select: { id: true, name: true } },
      },
    });
  }

  async findAll(
    schoolId: string,
    classId?: string,
    sectionId?: string,
    parentId?: string,
    userId?: string,
  ) {
    const where: Prisma.StudentWhereInput = { schoolId };
    if (classId) where.classId = classId;
    if (sectionId) where.sectionId = sectionId;
    if (parentId) where.parentId = parentId;
    if (userId) where.userId = userId;

    return this.prisma.student.findMany({
      where,
      include: {
        academicClass: { select: { id: true, name: true } },
        section: { select: { id: true, name: true } },
        user: { select: { id: true, username: true, status: true } },
        parent: { select: { id: true, username: true, status: true } },
      },
      orderBy: { rollNo: 'asc' },
    });
  }

  async findOne(id: string) {
    const student = await this.prisma.student.findUnique({
      where: { id },
      include: {
        academicClass: true,
        section: true,
        user: { select: { id: true, username: true, status: true } },
        parent: { select: { id: true, username: true, status: true } },
      },
    });
    if (!student) throw new NotFoundException('Student not found');
    return student;
  }
}

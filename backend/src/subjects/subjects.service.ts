import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { Prisma } from '@prisma/client';

@Injectable()
export class SubjectsService {
  constructor(private prisma: PrismaService) {}

  async create(createSubjectDto: Prisma.SubjectUncheckedCreateInput) {
    return this.prisma.subject.create({
      data: createSubjectDto,
      include: {
        teacher: { select: { id: true, name: true, email: true } },
      },
    });
  }

  async findAll(schoolId: string, classId?: string) {
    const where: Prisma.SubjectWhereInput = { schoolId };
    if (classId) where.classId = classId;
    return this.prisma.subject.findMany({
      where,
      include: {
        academicClass: { select: { id: true, name: true } },
        teacher: { select: { id: true, name: true, email: true } },
      },
      orderBy: { name: 'asc' },
    });
  }

  async findOne(id: string) {
    const subject = await this.prisma.subject.findUnique({
      where: { id },
      include: {
        academicClass: true,
        teacher: { select: { id: true, name: true, email: true } },
      },
    });
    if (!subject) throw new NotFoundException('Subject not found');
    return subject;
  }

  async remove(id: string) {
    await this.findOne(id);
    return this.prisma.subject.delete({ where: { id } });
  }
}

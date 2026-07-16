import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class SuperadminService {
  constructor(private prisma: PrismaService) {}

  async getStats() {
    const totalSchools = await this.prisma.school.count();
    const totalUsers = await this.prisma.user.count();

    // Count only active/enrolled students for revenue calculation
    const totalStudents = await this.prisma.student.count({
      where: {
        status: { in: ['REGISTERED', 'ENROLLED'] },
      },
    });

    // VortiQen charges ₹299 per student
    const totalRevenue = totalStudents * 299;

    return {
      totalSchools,
      totalUsers,
      totalStudents,
      totalRevenue,
    };
  }

  async getAllSchools() {
    return this.prisma.school.findMany({
      orderBy: { createdAt: 'desc' },
      include: {
        _count: {
          select: { students: true, users: true },
        },
      },
    });
  }

  async updateSchoolStatus(id: string, status: string) {
    const school = await this.prisma.school.findUnique({ where: { id } });
    if (!school) {
      throw new NotFoundException('School not found');
    }

    return this.prisma.school.update({
      where: { id },
      data: { status },
    });
  }
}

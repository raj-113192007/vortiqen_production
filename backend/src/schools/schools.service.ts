import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateSchoolDto } from './dto/create-school.dto';
import { UpdateSchoolDto } from './dto/update-school.dto';
import * as bcrypt from 'bcrypt';

@Injectable()
export class SchoolsService {
  constructor(private prisma: PrismaService) {}

  async create(createSchoolDto: CreateSchoolDto) {
    const { adminName, adminUsername, adminPassword, ...schoolData } =
      createSchoolDto;

    return this.prisma.$transaction(async (tx) => {
      // 1. Create the school
      const school = await tx.school.create({
        data: schoolData,
      });

      // 2. Create the school admin user if provided
      if (adminName && adminUsername && adminPassword) {
        const hashedPassword = await bcrypt.hash(adminPassword, 10);
        await tx.user.create({
          data: {
            schoolId: school.id,
            username: adminUsername,
            name: adminName,
            password: hashedPassword,
            role: 'SCHOOL_ADMIN',
          },
        });
      }

      return school;
    });
  }

  async findAll() {
    return this.prisma.school.findMany({
      orderBy: { createdAt: 'desc' },
    });
  }

  async findOne(id: string) {
    const school = await this.prisma.school.findUnique({
      where: { id },
      include: {
        users: {
          select: { id: true, name: true, role: true, status: true },
        },
      },
    });
    if (!school) {
      throw new NotFoundException(`School with ID ${id} not found`);
    }
    return school;
  }

  async update(id: string, updateSchoolDto: UpdateSchoolDto) {
    // Check if exists
    await this.findOne(id);
    return this.prisma.school.update({
      where: { id },
      data: updateSchoolDto,
    });
  }

  async remove(id: string) {
    // Check if exists
    await this.findOne(id);
    return this.prisma.school.delete({
      where: { id },
    });
  }
}

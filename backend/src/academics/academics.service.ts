import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateClassDto } from './dto/create-class.dto';

@Injectable()
export class AcademicsService {
  constructor(private readonly prisma: PrismaService) {}

  async createClass(schoolId: string, createDto: CreateClassDto) {
    return this.prisma.academicClass.create({
      data: {
        schoolId,
        name: createDto.name,
        monthlyFee: createDto.monthlyFee || 0,
        sections: {
          create: createDto.sections.map((section) => ({
            name: section.name,
          })),
        },
      },
      include: {
        sections: true,
      },
    });
  }

  async getClasses(schoolId: string) {
    return this.prisma.academicClass.findMany({
      where: { schoolId },
      include: {
        sections: {
          orderBy: { name: 'asc' },
        },
      },
      orderBy: {
        name: 'asc',
      },
    });
  }
}

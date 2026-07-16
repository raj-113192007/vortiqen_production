import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { Prisma } from '@prisma/client';

@Injectable()
export class CctvService {
  constructor(private prisma: PrismaService) {}

  async getAllCameras(schoolId: string) {
    return this.prisma.cctvCamera.findMany({
      where: { schoolId },
      orderBy: { name: 'asc' },
    });
  }

  async addCamera(
    schoolId: string,
    data: {
      name: string;
      location: string;
      streamUrl: string;
      status?: string;
    },
  ) {
    return this.prisma.cctvCamera.create({
      data: {
        schoolId,
        name: data.name,
        location: data.location,
        streamUrl: data.streamUrl,
        status: data.status ?? 'ACTIVE',
      },
    });
  }

  async updateCamera(
    id: string,
    schoolId: string,
    data: Prisma.CctvCameraUpdateInput,
  ) {
    return this.prisma.cctvCamera.updateMany({
      where: { id, schoolId },
      data,
    });
  }
}

import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import {
  CreateRouteDto,
  CreateVehicleDto,
  AssignStudentTransportDto,
} from './dto/create-transport.dto';

@Injectable()
export class TransportService {
  constructor(private prisma: PrismaService) {}

  async createRoute(dto: CreateRouteDto, schoolId: string) {
    return this.prisma.route.create({
      data: {
        schoolId,
        name: dto.name,
      },
    });
  }

  async getRoutes(schoolId: string) {
    return this.prisma.route.findMany({
      where: { schoolId },
      include: {
        vehicles: {
          include: { driver: true },
        },
      },
    });
  }

  async createVehicle(dto: CreateVehicleDto, schoolId: string) {
    return this.prisma.vehicle.create({
      data: {
        schoolId,
        plateNumber: dto.plateNumber,
        capacity: dto.capacity,
        driverId: dto.driverId,
        routeId: dto.routeId,
      },
      include: {
        driver: true,
        route: true,
      },
    });
  }

  async getVehicles(schoolId: string) {
    return this.prisma.vehicle.findMany({
      where: { schoolId },
      include: {
        driver: true,
        route: true,
      },
    });
  }

  async assignStudent(dto: AssignStudentTransportDto, schoolId: string) {
    return this.prisma.student.update({
      where: { id: dto.studentId, schoolId },
      data: {
        routeId: dto.routeId,
        vehicleId: dto.vehicleId,
      },
      include: {
        route: true,
        vehicle: true,
      },
    });
  }

  async getStudentTransportDetails(studentId: string, schoolId: string) {
    const student = await this.prisma.student.findFirst({
      where: { id: studentId, schoolId },
      include: {
        route: true,
        vehicle: {
          include: { driver: true },
        },
      },
    });

    if (!student) throw new NotFoundException('Student not found');
    return student;
  }

  async getDriverTransportDetails(driverId: string, schoolId: string) {
    const vehicle = await this.prisma.vehicle.findFirst({
      where: { driverId, schoolId },
      include: {
        route: true,
        students: {
          include: {
            academicClass: true,
            section: true,
          },
        },
      },
    });

    return vehicle;
  }
}

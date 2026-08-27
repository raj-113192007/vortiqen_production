"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.TransportService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
let TransportService = class TransportService {
    prisma;
    constructor(prisma) {
        this.prisma = prisma;
    }
    async createRoute(dto, schoolId) {
        return this.prisma.route.create({
            data: {
                schoolId,
                name: dto.name,
            },
        });
    }
    async getRoutes(schoolId) {
        return this.prisma.route.findMany({
            where: { schoolId },
            include: {
                vehicles: {
                    include: { driver: true },
                },
            },
        });
    }
    async createVehicle(dto, schoolId) {
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
    async getVehicles(schoolId) {
        return this.prisma.vehicle.findMany({
            where: { schoolId },
            include: {
                driver: true,
                route: true,
            },
        });
    }
    async assignStudent(dto, schoolId) {
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
    async getStudentTransportDetails(studentId, schoolId) {
        const student = await this.prisma.student.findFirst({
            where: { id: studentId, schoolId },
            include: {
                route: true,
                vehicle: {
                    include: { driver: true },
                },
            },
        });
        if (!student)
            throw new common_1.NotFoundException('Student not found');
        return student;
    }
    async getDriverTransportDetails(driverId, schoolId) {
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
};
exports.TransportService = TransportService;
exports.TransportService = TransportService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], TransportService);
//# sourceMappingURL=transport.service.js.map
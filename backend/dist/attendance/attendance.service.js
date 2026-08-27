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
exports.AttendanceService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
let AttendanceService = class AttendanceService {
    prisma;
    constructor(prisma) {
        this.prisma = prisma;
    }
    async markAttendance(schoolId, date, studentStatuses, markedById) {
        const attendanceDate = new Date(date);
        attendanceDate.setUTCHours(0, 0, 0, 0);
        const results = await this.prisma.$transaction(studentStatuses.map((ss) => this.prisma.attendance.upsert({
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
        })));
        return { success: true, count: results.length };
    }
    async getAttendanceByClass(schoolId, classId, sectionId, date) {
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
    async getAttendanceByStudent(schoolId, studentId) {
        return this.prisma.attendance.findMany({
            where: { schoolId, studentId },
            orderBy: { date: 'desc' },
            take: 30,
        });
    }
};
exports.AttendanceService = AttendanceService;
exports.AttendanceService = AttendanceService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], AttendanceService);
//# sourceMappingURL=attendance.service.js.map
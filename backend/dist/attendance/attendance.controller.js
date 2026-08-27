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
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AttendanceController = void 0;
const common_1 = require("@nestjs/common");
const attendance_service_1 = require("./attendance.service");
const jwt_auth_guard_1 = require("../common/guards/jwt-auth.guard");
const roles_guard_1 = require("../common/guards/roles.guard");
const roles_decorator_1 = require("../common/decorators/roles.decorator");
const school_id_decorator_1 = require("../common/decorators/school-id.decorator");
let AttendanceController = class AttendanceController {
    attendanceService;
    constructor(attendanceService) {
        this.attendanceService = attendanceService;
    }
    async markAttendance(schoolId, body) {
        return this.attendanceService.markAttendance(schoolId, body.date, body.studentStatuses, body.markedById);
    }
    async getAttendanceByClass(schoolId, classId, sectionId, date) {
        return this.attendanceService.getAttendanceByClass(schoolId, classId, sectionId, date);
    }
    async getAttendanceByStudent(schoolId, studentId) {
        return this.attendanceService.getAttendanceByStudent(schoolId, studentId);
    }
};
exports.AttendanceController = AttendanceController;
__decorate([
    (0, roles_decorator_1.Roles)('SUPER_ADMIN', 'SCHOOL_ADMIN', 'TEACHER'),
    (0, common_1.Post)(),
    __param(0, (0, school_id_decorator_1.SchoolId)()),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, Object]),
    __metadata("design:returntype", Promise)
], AttendanceController.prototype, "markAttendance", null);
__decorate([
    (0, roles_decorator_1.Roles)('SUPER_ADMIN', 'SCHOOL_ADMIN', 'TEACHER'),
    (0, common_1.Get)('class'),
    __param(0, (0, school_id_decorator_1.SchoolId)()),
    __param(1, (0, common_1.Query)('classId')),
    __param(2, (0, common_1.Query)('sectionId')),
    __param(3, (0, common_1.Query)('date')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, String, String, String]),
    __metadata("design:returntype", Promise)
], AttendanceController.prototype, "getAttendanceByClass", null);
__decorate([
    (0, roles_decorator_1.Roles)('SUPER_ADMIN', 'SCHOOL_ADMIN', 'TEACHER', 'PARENT', 'STUDENT'),
    (0, common_1.Get)('student'),
    __param(0, (0, school_id_decorator_1.SchoolId)()),
    __param(1, (0, common_1.Query)('studentId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, String]),
    __metadata("design:returntype", Promise)
], AttendanceController.prototype, "getAttendanceByStudent", null);
exports.AttendanceController = AttendanceController = __decorate([
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard, roles_guard_1.RolesGuard),
    (0, common_1.Controller)('api/v1/attendance'),
    __metadata("design:paramtypes", [attendance_service_1.AttendanceService])
], AttendanceController);
//# sourceMappingURL=attendance.controller.js.map
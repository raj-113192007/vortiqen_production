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
exports.TransportController = void 0;
const common_1 = require("@nestjs/common");
const transport_service_1 = require("./transport.service");
const create_transport_dto_1 = require("./dto/create-transport.dto");
const roles_guard_1 = require("../common/guards/roles.guard");
const roles_decorator_1 = require("../common/decorators/roles.decorator");
let TransportController = class TransportController {
    transportService;
    constructor(transportService) {
        this.transportService = transportService;
    }
    createRoute(dto, req) {
        return this.transportService.createRoute(dto, req.user.schoolId);
    }
    getRoutes(req) {
        return this.transportService.getRoutes(req.user.schoolId);
    }
    createVehicle(dto, req) {
        return this.transportService.createVehicle(dto, req.user.schoolId);
    }
    getVehicles(req) {
        return this.transportService.getVehicles(req.user.schoolId);
    }
    assignStudent(dto, req) {
        return this.transportService.assignStudent(dto, req.user.schoolId);
    }
    getStudentTransportDetails(studentId, req) {
        return this.transportService.getStudentTransportDetails(studentId, req.user.schoolId);
    }
    getDriverTransportDetails(req) {
        return this.transportService.getDriverTransportDetails(req.user.userId, req.user.schoolId);
    }
};
exports.TransportController = TransportController;
__decorate([
    (0, common_1.Post)('routes'),
    (0, roles_decorator_1.Roles)('SCHOOL_ADMIN'),
    __param(0, (0, common_1.Body)()),
    __param(1, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [create_transport_dto_1.CreateRouteDto, Object]),
    __metadata("design:returntype", void 0)
], TransportController.prototype, "createRoute", null);
__decorate([
    (0, common_1.Get)('routes'),
    (0, roles_decorator_1.Roles)('SCHOOL_ADMIN', 'TEACHER', 'DRIVER'),
    __param(0, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", void 0)
], TransportController.prototype, "getRoutes", null);
__decorate([
    (0, common_1.Post)('vehicles'),
    (0, roles_decorator_1.Roles)('SCHOOL_ADMIN'),
    __param(0, (0, common_1.Body)()),
    __param(1, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [create_transport_dto_1.CreateVehicleDto, Object]),
    __metadata("design:returntype", void 0)
], TransportController.prototype, "createVehicle", null);
__decorate([
    (0, common_1.Get)('vehicles'),
    (0, roles_decorator_1.Roles)('SCHOOL_ADMIN', 'TEACHER', 'DRIVER'),
    __param(0, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", void 0)
], TransportController.prototype, "getVehicles", null);
__decorate([
    (0, common_1.Post)('assign'),
    (0, roles_decorator_1.Roles)('SCHOOL_ADMIN'),
    __param(0, (0, common_1.Body)()),
    __param(1, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [create_transport_dto_1.AssignStudentTransportDto, Object]),
    __metadata("design:returntype", void 0)
], TransportController.prototype, "assignStudent", null);
__decorate([
    (0, common_1.Get)('student/:studentId'),
    (0, roles_decorator_1.Roles)('SCHOOL_ADMIN', 'TEACHER', 'STUDENT', 'PARENT'),
    __param(0, (0, common_1.Param)('studentId')),
    __param(1, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, Object]),
    __metadata("design:returntype", void 0)
], TransportController.prototype, "getStudentTransportDetails", null);
__decorate([
    (0, common_1.Get)('driver/my-details'),
    (0, roles_decorator_1.Roles)('DRIVER'),
    __param(0, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", void 0)
], TransportController.prototype, "getDriverTransportDetails", null);
exports.TransportController = TransportController = __decorate([
    (0, common_1.Controller)('transport'),
    (0, common_1.UseGuards)(roles_guard_1.RolesGuard),
    __metadata("design:paramtypes", [transport_service_1.TransportService])
], TransportController);
//# sourceMappingURL=transport.controller.js.map
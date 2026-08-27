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
exports.HrController = void 0;
const common_1 = require("@nestjs/common");
const hr_service_1 = require("./hr.service");
const roles_guard_1 = require("../common/guards/roles.guard");
const roles_decorator_1 = require("../common/decorators/roles.decorator");
let HrController = class HrController {
    hrService;
    constructor(hrService) {
        this.hrService = hrService;
    }
    findAllEmployees(req) {
        return this.hrService.findAllEmployees(req.user.schoolId);
    }
    getMyEmployeeProfile(req) {
        return this.hrService.getMyEmployeeProfile(req.user.userId);
    }
    createEmployee(req, createEmployeeDto) {
        return this.hrService.createEmployee(req.user.schoolId, createEmployeeDto);
    }
    findPayrolls(req, month, year) {
        return this.hrService.findPayrolls(req.user.schoolId, month ? parseInt(month, 10) : new Date().getMonth() + 1, year ? parseInt(year, 10) : new Date().getFullYear());
    }
    getMyPayrolls(req) {
        return this.hrService.getMyPayrolls(req.user.userId);
    }
    generatePayroll(req, data) {
        return this.hrService.generatePayroll(req.user.schoolId, data.month, data.year);
    }
    markAsPaid(req, id) {
        return this.hrService.markAsPaid(req.user.schoolId, id);
    }
};
exports.HrController = HrController;
__decorate([
    (0, common_1.Get)('employees'),
    (0, common_1.UseGuards)(roles_guard_1.RolesGuard),
    (0, roles_decorator_1.Roles)('SUPER_ADMIN', 'SCHOOL_ADMIN', 'DIRECTOR'),
    __param(0, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", void 0)
], HrController.prototype, "findAllEmployees", null);
__decorate([
    (0, common_1.Get)('employees/me'),
    (0, common_1.UseGuards)(roles_guard_1.RolesGuard),
    __param(0, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", void 0)
], HrController.prototype, "getMyEmployeeProfile", null);
__decorate([
    (0, common_1.Post)('employees'),
    (0, common_1.UseGuards)(roles_guard_1.RolesGuard),
    (0, roles_decorator_1.Roles)('SUPER_ADMIN', 'SCHOOL_ADMIN', 'DIRECTOR'),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object]),
    __metadata("design:returntype", void 0)
], HrController.prototype, "createEmployee", null);
__decorate([
    (0, common_1.Get)('payroll'),
    (0, common_1.UseGuards)(roles_guard_1.RolesGuard),
    (0, roles_decorator_1.Roles)('SUPER_ADMIN', 'SCHOOL_ADMIN', 'DIRECTOR'),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Query)('month')),
    __param(2, (0, common_1.Query)('year')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, String, String]),
    __metadata("design:returntype", void 0)
], HrController.prototype, "findPayrolls", null);
__decorate([
    (0, common_1.Get)('payroll/me'),
    (0, common_1.UseGuards)(roles_guard_1.RolesGuard),
    __param(0, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", void 0)
], HrController.prototype, "getMyPayrolls", null);
__decorate([
    (0, common_1.Post)('payroll/generate'),
    (0, common_1.UseGuards)(roles_guard_1.RolesGuard),
    (0, roles_decorator_1.Roles)('SUPER_ADMIN', 'SCHOOL_ADMIN', 'DIRECTOR'),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object]),
    __metadata("design:returntype", void 0)
], HrController.prototype, "generatePayroll", null);
__decorate([
    (0, common_1.Patch)('payroll/:id/pay'),
    (0, common_1.UseGuards)(roles_guard_1.RolesGuard),
    (0, roles_decorator_1.Roles)('SUPER_ADMIN', 'SCHOOL_ADMIN', 'DIRECTOR'),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, String]),
    __metadata("design:returntype", void 0)
], HrController.prototype, "markAsPaid", null);
exports.HrController = HrController = __decorate([
    (0, common_1.Controller)('hr'),
    __metadata("design:paramtypes", [hr_service_1.HrService])
], HrController);
//# sourceMappingURL=hr.controller.js.map
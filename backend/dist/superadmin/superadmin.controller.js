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
exports.SuperadminController = void 0;
const common_1 = require("@nestjs/common");
const superadmin_service_1 = require("./superadmin.service");
const roles_guard_1 = require("../common/guards/roles.guard");
const roles_decorator_1 = require("../common/decorators/roles.decorator");
let SuperadminController = class SuperadminController {
    superadminService;
    constructor(superadminService) {
        this.superadminService = superadminService;
    }
    getStats() {
        return this.superadminService.getStats();
    }
    getAllSchools() {
        return this.superadminService.getAllSchools();
    }
    updateSchoolStatus(id, status) {
        return this.superadminService.updateSchoolStatus(id, status);
    }
};
exports.SuperadminController = SuperadminController;
__decorate([
    (0, common_1.Get)('stats'),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", void 0)
], SuperadminController.prototype, "getStats", null);
__decorate([
    (0, common_1.Get)('schools'),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", void 0)
], SuperadminController.prototype, "getAllSchools", null);
__decorate([
    (0, common_1.Patch)('schools/:id/status'),
    __param(0, (0, common_1.Param)('id')),
    __param(1, (0, common_1.Body)('status')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, String]),
    __metadata("design:returntype", void 0)
], SuperadminController.prototype, "updateSchoolStatus", null);
exports.SuperadminController = SuperadminController = __decorate([
    (0, common_1.Controller)('superadmin'),
    (0, common_1.UseGuards)(roles_guard_1.RolesGuard),
    (0, roles_decorator_1.Roles)('SUPER_ADMIN'),
    __metadata("design:paramtypes", [superadmin_service_1.SuperadminService])
], SuperadminController);
//# sourceMappingURL=superadmin.controller.js.map
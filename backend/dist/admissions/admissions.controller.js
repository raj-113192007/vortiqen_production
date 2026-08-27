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
exports.AdmissionsController = void 0;
const common_1 = require("@nestjs/common");
const admissions_service_1 = require("./admissions.service");
const create_enquiry_dto_1 = require("./dto/create-enquiry.dto");
const update_enquiry_dto_1 = require("./dto/update-enquiry.dto");
const jwt_auth_guard_1 = require("../common/guards/jwt-auth.guard");
const roles_guard_1 = require("../common/guards/roles.guard");
const roles_decorator_1 = require("../common/decorators/roles.decorator");
let AdmissionsController = class AdmissionsController {
    admissionsService;
    constructor(admissionsService) {
        this.admissionsService = admissionsService;
    }
    createPublicEnquiry(createEnquiryDto) {
        if (!createEnquiryDto.schoolId) {
            return {
                success: false,
                message: 'schoolId is required for public enquiry',
            };
        }
        return this.admissionsService.createEnquiry(createEnquiryDto);
    }
    createEnquiry(req, createEnquiryDto) {
        return this.admissionsService.createEnquiry(createEnquiryDto, req.user.schoolId);
    }
    findAll(req, status) {
        return this.admissionsService.findAllBySchool(req.user.schoolId, status);
    }
    findOne(req, id) {
        return this.admissionsService.findOne(id, req.user.schoolId);
    }
    update(req, id, updateEnquiryDto) {
        return this.admissionsService.update(id, req.user.schoolId, updateEnquiryDto);
    }
};
exports.AdmissionsController = AdmissionsController;
__decorate([
    (0, common_1.Post)('public/enquiry'),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [create_enquiry_dto_1.CreateEnquiryDto]),
    __metadata("design:returntype", void 0)
], AdmissionsController.prototype, "createPublicEnquiry", null);
__decorate([
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard, roles_guard_1.RolesGuard),
    (0, roles_decorator_1.Roles)('SCHOOL_ADMIN', 'SUPER_ADMIN'),
    (0, common_1.Post)('enquiry'),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, create_enquiry_dto_1.CreateEnquiryDto]),
    __metadata("design:returntype", void 0)
], AdmissionsController.prototype, "createEnquiry", null);
__decorate([
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard, roles_guard_1.RolesGuard),
    (0, roles_decorator_1.Roles)('SCHOOL_ADMIN', 'SUPER_ADMIN'),
    (0, common_1.Get)('enquiries'),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Query)('status')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, String]),
    __metadata("design:returntype", void 0)
], AdmissionsController.prototype, "findAll", null);
__decorate([
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard, roles_guard_1.RolesGuard),
    (0, roles_decorator_1.Roles)('SCHOOL_ADMIN', 'SUPER_ADMIN'),
    (0, common_1.Get)('enquiry/:id'),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, String]),
    __metadata("design:returntype", void 0)
], AdmissionsController.prototype, "findOne", null);
__decorate([
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard, roles_guard_1.RolesGuard),
    (0, roles_decorator_1.Roles)('SCHOOL_ADMIN', 'SUPER_ADMIN'),
    (0, common_1.Patch)('enquiry/:id'),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Param)('id')),
    __param(2, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, String, update_enquiry_dto_1.UpdateEnquiryDto]),
    __metadata("design:returntype", void 0)
], AdmissionsController.prototype, "update", null);
exports.AdmissionsController = AdmissionsController = __decorate([
    (0, common_1.Controller)('admissions'),
    __metadata("design:paramtypes", [admissions_service_1.AdmissionsService])
], AdmissionsController);
//# sourceMappingURL=admissions.controller.js.map
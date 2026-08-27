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
exports.SubjectsController = void 0;
const common_1 = require("@nestjs/common");
const subjects_service_1 = require("./subjects.service");
const jwt_auth_guard_1 = require("../common/guards/jwt-auth.guard");
const roles_guard_1 = require("../common/guards/roles.guard");
const roles_decorator_1 = require("../common/decorators/roles.decorator");
const client_1 = require("@prisma/client");
let SubjectsController = class SubjectsController {
    subjectsService;
    constructor(subjectsService) {
        this.subjectsService = subjectsService;
    }
    create(createSubjectDto) {
        return this.subjectsService.create(createSubjectDto);
    }
    findAll(schoolId, classId) {
        return this.subjectsService.findAll(schoolId, classId);
    }
    findOne(id) {
        return this.subjectsService.findOne(id);
    }
    remove(id) {
        return this.subjectsService.remove(id);
    }
};
exports.SubjectsController = SubjectsController;
__decorate([
    (0, roles_decorator_1.Roles)('SUPER_ADMIN', 'SCHOOL_ADMIN', 'DIRECTOR'),
    (0, common_1.Post)(),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", void 0)
], SubjectsController.prototype, "create", null);
__decorate([
    (0, roles_decorator_1.Roles)('SUPER_ADMIN', 'SCHOOL_ADMIN', 'DIRECTOR', 'TEACHER', 'STUDENT', 'PARENT'),
    (0, common_1.Get)(),
    __param(0, (0, common_1.Query)('schoolId')),
    __param(1, (0, common_1.Query)('classId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, String]),
    __metadata("design:returntype", void 0)
], SubjectsController.prototype, "findAll", null);
__decorate([
    (0, roles_decorator_1.Roles)('SUPER_ADMIN', 'SCHOOL_ADMIN', 'DIRECTOR', 'TEACHER', 'STUDENT', 'PARENT'),
    (0, common_1.Get)(':id'),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], SubjectsController.prototype, "findOne", null);
__decorate([
    (0, roles_decorator_1.Roles)('SUPER_ADMIN', 'SCHOOL_ADMIN', 'DIRECTOR'),
    (0, common_1.Delete)(':id'),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", void 0)
], SubjectsController.prototype, "remove", null);
exports.SubjectsController = SubjectsController = __decorate([
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard, roles_guard_1.RolesGuard),
    (0, common_1.Controller)('subjects'),
    __metadata("design:paramtypes", [subjects_service_1.SubjectsService])
], SubjectsController);
//# sourceMappingURL=subjects.controller.js.map
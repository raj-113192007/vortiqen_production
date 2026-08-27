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
exports.AcademicsController = void 0;
const common_1 = require("@nestjs/common");
const academics_service_1 = require("./academics.service");
const create_class_dto_1 = require("./dto/create-class.dto");
const jwt_auth_guard_1 = require("../common/guards/jwt-auth.guard");
const school_scope_guard_1 = require("../common/guards/school-scope.guard");
let AcademicsController = class AcademicsController {
    academicsService;
    constructor(academicsService) {
        this.academicsService = academicsService;
    }
    async createClass(createDto, req) {
        const data = await this.academicsService.createClass(req.user.schoolId, createDto);
        return { success: true, data };
    }
    async getClasses(req) {
        const data = await this.academicsService.getClasses(req.user.schoolId);
        return { success: true, data };
    }
};
exports.AcademicsController = AcademicsController;
__decorate([
    (0, common_1.Post)(),
    __param(0, (0, common_1.Body)()),
    __param(1, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [create_class_dto_1.CreateClassDto, Object]),
    __metadata("design:returntype", Promise)
], AcademicsController.prototype, "createClass", null);
__decorate([
    (0, common_1.Get)(),
    __param(0, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], AcademicsController.prototype, "getClasses", null);
exports.AcademicsController = AcademicsController = __decorate([
    (0, common_1.Controller)('api/v1/classes'),
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard, school_scope_guard_1.SchoolScopeGuard),
    __metadata("design:paramtypes", [academics_service_1.AcademicsService])
], AcademicsController);
//# sourceMappingURL=academics.controller.js.map
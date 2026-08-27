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
exports.FeesController = void 0;
const common_1 = require("@nestjs/common");
const fees_service_1 = require("./fees.service");
const jwt_auth_guard_1 = require("../common/guards/jwt-auth.guard");
const roles_guard_1 = require("../common/guards/roles.guard");
const roles_decorator_1 = require("../common/decorators/roles.decorator");
const school_id_decorator_1 = require("../common/decorators/school-id.decorator");
let FeesController = class FeesController {
    feesService;
    constructor(feesService) {
        this.feesService = feesService;
    }
    async createCategory(schoolId, body) {
        return this.feesService.createCategory(schoolId, body.name, body.amount);
    }
    async getCategories(schoolId) {
        return this.feesService.getCategories(schoolId);
    }
    async generateLedgers(schoolId, body) {
        return this.feesService.generateLedgers(schoolId, body.categoryId, body.dueDate, body.classId);
    }
    async getLedgers(schoolId, classId, sectionId) {
        return this.feesService.getLedgers(schoolId, classId, sectionId);
    }
    async recordPayment(schoolId, body) {
        return this.feesService.recordPayment(schoolId, body.ledgerId, body.amountPaid, body.paymentMethod, body.receiptNo);
    }
};
exports.FeesController = FeesController;
__decorate([
    (0, roles_decorator_1.Roles)('SUPER_ADMIN', 'SCHOOL_ADMIN'),
    (0, common_1.Post)('categories'),
    __param(0, (0, school_id_decorator_1.SchoolId)()),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, Object]),
    __metadata("design:returntype", Promise)
], FeesController.prototype, "createCategory", null);
__decorate([
    (0, roles_decorator_1.Roles)('SUPER_ADMIN', 'SCHOOL_ADMIN', 'PARENT', 'STUDENT'),
    (0, common_1.Get)('categories'),
    __param(0, (0, school_id_decorator_1.SchoolId)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], FeesController.prototype, "getCategories", null);
__decorate([
    (0, roles_decorator_1.Roles)('SUPER_ADMIN', 'SCHOOL_ADMIN'),
    (0, common_1.Post)('ledgers/generate'),
    __param(0, (0, school_id_decorator_1.SchoolId)()),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, Object]),
    __metadata("design:returntype", Promise)
], FeesController.prototype, "generateLedgers", null);
__decorate([
    (0, roles_decorator_1.Roles)('SUPER_ADMIN', 'SCHOOL_ADMIN', 'PARENT', 'STUDENT'),
    (0, common_1.Get)('ledgers'),
    __param(0, (0, school_id_decorator_1.SchoolId)()),
    __param(1, (0, common_1.Query)('classId')),
    __param(2, (0, common_1.Query)('sectionId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, String, String]),
    __metadata("design:returntype", Promise)
], FeesController.prototype, "getLedgers", null);
__decorate([
    (0, roles_decorator_1.Roles)('SUPER_ADMIN', 'SCHOOL_ADMIN'),
    (0, common_1.Post)('pay'),
    __param(0, (0, school_id_decorator_1.SchoolId)()),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, Object]),
    __metadata("design:returntype", Promise)
], FeesController.prototype, "recordPayment", null);
exports.FeesController = FeesController = __decorate([
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard, roles_guard_1.RolesGuard),
    (0, common_1.Controller)('api/v1/fees'),
    __metadata("design:paramtypes", [fees_service_1.FeesService])
], FeesController);
//# sourceMappingURL=fees.controller.js.map
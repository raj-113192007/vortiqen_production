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
exports.InventoryController = void 0;
const common_1 = require("@nestjs/common");
const inventory_service_1 = require("./inventory.service");
const jwt_auth_guard_1 = require("../common/guards/jwt-auth.guard");
const roles_guard_1 = require("../common/guards/roles.guard");
const roles_decorator_1 = require("../common/decorators/roles.decorator");
let InventoryController = class InventoryController {
    inventoryService;
    constructor(inventoryService) {
        this.inventoryService = inventoryService;
    }
    getCategories(req) {
        return this.inventoryService.getCategories(req.user.schoolId);
    }
    createCategory(req, data) {
        return this.inventoryService.createCategory(req.user.schoolId, data);
    }
    getAssets(req, categoryId, status) {
        return this.inventoryService.getAssets(req.user.schoolId, categoryId, status);
    }
    createAsset(req, data) {
        return this.inventoryService.createAsset(req.user.schoolId, data);
    }
    assignAsset(req, assetId, data) {
        const assignData = {
            ...data,
            adminId: req.user.userId,
        };
        return this.inventoryService.assignAsset(req.user.schoolId, assetId, assignData);
    }
};
exports.InventoryController = InventoryController;
__decorate([
    (0, common_1.Get)('categories'),
    (0, roles_decorator_1.Roles)('SUPER_ADMIN', 'SCHOOL_ADMIN'),
    __param(0, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", void 0)
], InventoryController.prototype, "getCategories", null);
__decorate([
    (0, common_1.Post)('categories'),
    (0, roles_decorator_1.Roles)('SUPER_ADMIN', 'SCHOOL_ADMIN'),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object]),
    __metadata("design:returntype", void 0)
], InventoryController.prototype, "createCategory", null);
__decorate([
    (0, common_1.Get)('assets'),
    (0, roles_decorator_1.Roles)('SUPER_ADMIN', 'SCHOOL_ADMIN', 'TEACHER', 'DIRECTOR'),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Query)('categoryId')),
    __param(2, (0, common_1.Query)('status')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, String, String]),
    __metadata("design:returntype", void 0)
], InventoryController.prototype, "getAssets", null);
__decorate([
    (0, common_1.Post)('assets'),
    (0, roles_decorator_1.Roles)('SUPER_ADMIN', 'SCHOOL_ADMIN'),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, Object]),
    __metadata("design:returntype", void 0)
], InventoryController.prototype, "createAsset", null);
__decorate([
    (0, common_1.Post)('assets/:id/assign'),
    (0, roles_decorator_1.Roles)('SUPER_ADMIN', 'SCHOOL_ADMIN'),
    __param(0, (0, common_1.Request)()),
    __param(1, (0, common_1.Param)('id')),
    __param(2, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, String, Object]),
    __metadata("design:returntype", void 0)
], InventoryController.prototype, "assignAsset", null);
exports.InventoryController = InventoryController = __decorate([
    (0, common_1.Controller)('inventory'),
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard, roles_guard_1.RolesGuard),
    __metadata("design:paramtypes", [inventory_service_1.InventoryService])
], InventoryController);
//# sourceMappingURL=inventory.controller.js.map
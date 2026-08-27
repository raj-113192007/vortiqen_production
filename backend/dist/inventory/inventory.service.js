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
exports.InventoryService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
let InventoryService = class InventoryService {
    prisma;
    constructor(prisma) {
        this.prisma = prisma;
    }
    async getCategories(schoolId) {
        return this.prisma.assetCategory.findMany({
            where: { schoolId },
        });
    }
    async createCategory(schoolId, data) {
        return this.prisma.assetCategory.create({
            data: {
                schoolId,
                name: data.name,
                description: data.description,
            },
        });
    }
    async getAssets(schoolId, categoryId, status) {
        const whereClause = { schoolId };
        if (categoryId)
            whereClause.categoryId = categoryId;
        if (status)
            whereClause.status = status;
        return this.prisma.asset.findMany({
            where: whereClause,
            include: {
                category: true,
                assignedTo: {
                    select: { id: true, name: true, role: true },
                },
            },
        });
    }
    async createAsset(schoolId, data) {
        return this.prisma.asset.create({
            data: {
                schoolId,
                categoryId: data.categoryId,
                name: data.name,
                sku: data.sku,
                purchaseDate: data.purchaseDate ? new Date(data.purchaseDate) : null,
                depreciationRate: data.depreciationRate
                    ? typeof data.depreciationRate === 'string'
                        ? parseFloat(data.depreciationRate)
                        : data.depreciationRate
                    : null,
                status: data.status || 'AVAILABLE',
                condition: data.condition || 'GOOD',
                location: data.location,
            },
        });
    }
    async assignAsset(schoolId, assetId, data) {
        const asset = await this.prisma.asset.findFirst({
            where: { id: assetId, schoolId },
        });
        if (!asset) {
            throw new common_1.NotFoundException('Asset not found');
        }
        if (asset.status !== 'AVAILABLE' && data.action === 'CHECK_OUT') {
            throw new common_1.BadRequestException('Asset is not available for assignment');
        }
        const newStatus = data.action === 'CHECK_OUT' ? 'ASSIGNED' : 'AVAILABLE';
        const assignedUser = data.action === 'CHECK_OUT' ? data.userId : null;
        const [updatedAsset, _] = await this.prisma.$transaction([
            this.prisma.asset.update({
                where: { id: assetId },
                data: {
                    status: newStatus,
                    assignedToUser: assignedUser,
                },
            }),
            this.prisma.assetLog.create({
                data: {
                    assetId,
                    action: data.action,
                    userId: data.userId,
                    adminId: data.adminId,
                    notes: data.notes,
                },
            }),
        ]);
        return updatedAsset;
    }
};
exports.InventoryService = InventoryService;
exports.InventoryService = InventoryService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], InventoryService);
//# sourceMappingURL=inventory.service.js.map
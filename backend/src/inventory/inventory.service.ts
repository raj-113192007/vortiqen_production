import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class InventoryService {
  constructor(private prisma: PrismaService) {}

  // Categories
  async getCategories(schoolId: string) {
    return this.prisma.assetCategory.findMany({
      where: { schoolId },
    });
  }

  async createCategory(schoolId: string, data: any) {
    return this.prisma.assetCategory.create({
      data: {
        schoolId,
        name: data.name,
        description: data.description,
      },
    });
  }

  // Assets
  async getAssets(schoolId: string, categoryId?: string, status?: string) {
    const whereClause: any = { schoolId };
    if (categoryId) whereClause.categoryId = categoryId;
    if (status) whereClause.status = status;

    return this.prisma.asset.findMany({
      where: whereClause,
      include: {
        category: true,
        assignedTo: {
          select: { id: true, name: true, role: true }
        }
      },
    });
  }

  async createAsset(schoolId: string, data: any) {
    return this.prisma.asset.create({
      data: {
        schoolId,
        categoryId: data.categoryId,
        name: data.name,
        sku: data.sku,
        purchaseDate: data.purchaseDate ? new Date(data.purchaseDate) : null,
        depreciationRate: data.depreciationRate ? parseFloat(data.depreciationRate) : null,
        status: data.status || 'AVAILABLE',
        condition: data.condition || 'GOOD',
        location: data.location,
      },
    });
  }

  // Assignment & Log
  async assignAsset(schoolId: string, assetId: string, data: any) {
    const asset = await this.prisma.asset.findFirst({
      where: { id: assetId, schoolId },
    });

    if (!asset) {
      throw new NotFoundException('Asset not found');
    }

    if (asset.status !== 'AVAILABLE' && data.action === 'CHECK_OUT') {
      throw new BadRequestException('Asset is not available for assignment');
    }

    const newStatus = data.action === 'CHECK_OUT' ? 'ASSIGNED' : 'AVAILABLE';
    const assignedUser = data.action === 'CHECK_OUT' ? data.userId : null;

    // Transaction to update asset and create log
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
          userId: data.userId, // Who it was assigned to or returned by
          adminId: data.adminId, // Who performed the action
          notes: data.notes,
        },
      })
    ]);

    return updatedAsset;
  }
}

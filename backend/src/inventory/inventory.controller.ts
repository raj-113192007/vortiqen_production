import {
  Controller,
  Get,
  Post,
  Param,
  Body,
  Query,
  UseGuards,
  Request,
} from '@nestjs/common';
import { InventoryService } from './inventory.service';
import { JwtAuthGuard } from '../common/guards/jwt-auth.guard';
import { RolesGuard } from '../common/guards/roles.guard';
import { Roles } from '../common/decorators/roles.decorator';
import type { AuthenticatedRequest } from '../common/interfaces/authenticated-request.interface';

@Controller('inventory')
@UseGuards(JwtAuthGuard, RolesGuard)
export class InventoryController {
  constructor(private readonly inventoryService: InventoryService) {}

  @Get('categories')
  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN')
  getCategories(@Request() req: AuthenticatedRequest) {
    return this.inventoryService.getCategories(req.user.schoolId!);
  }

  @Post('categories')
  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN')
  createCategory(
    @Request() req: AuthenticatedRequest,
    @Body() data: { name: string; description?: string },
  ) {
    return this.inventoryService.createCategory(req.user.schoolId!, data);
  }

  @Get('assets')
  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN', 'TEACHER', 'DIRECTOR')
  getAssets(
    @Request() req: AuthenticatedRequest,
    @Query('categoryId') categoryId?: string,
    @Query('status') status?: string,
  ) {
    return this.inventoryService.getAssets(
      req.user.schoolId!,
      categoryId,
      status,
    );
  }

  @Post('assets')
  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN')
  createAsset(
    @Request() req: AuthenticatedRequest,
    @Body()
    data: {
      categoryId: string;
      name: string;
      sku: string;
      purchaseDate?: string | Date;
      depreciationRate?: string | number;
      status?: string;
      condition?: string;
      location?: string;
    },
  ) {
    return this.inventoryService.createAsset(req.user.schoolId!, data);
  }

  @Post('assets/:id/assign')
  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN')
  assignAsset(
    @Request() req: AuthenticatedRequest,
    @Param('id') assetId: string,
    @Body()
    data: { action: string; userId: string; notes?: string; adminId?: string },
  ) {
    // data should contain { action: 'CHECK_OUT' | 'CHECK_IN', userId: string, notes?: string }
    const assignData = {
      ...data,
      adminId: req.user.userId,
    };
    return this.inventoryService.assignAsset(
      req.user.schoolId!,
      assetId,
      assignData,
    );
  }
}

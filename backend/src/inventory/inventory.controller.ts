import { Controller, Get, Post, Patch, Param, Body, Query, UseGuards, Request } from '@nestjs/common';
import { InventoryService } from './inventory.service';
import { JwtAuthGuard } from '../common/guards/jwt-auth.guard';
import { RolesGuard } from '../common/guards/roles.guard';
import { Roles } from '../common/decorators/roles.decorator';

@Controller('inventory')
@UseGuards(JwtAuthGuard, RolesGuard)
export class InventoryController {
  constructor(private readonly inventoryService: InventoryService) {}

  @Get('categories')
  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN')
  getCategories(@Request() req: any) {
    return this.inventoryService.getCategories(req.user.schoolId);
  }

  @Post('categories')
  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN')
  createCategory(@Request() req: any, @Body() data: any) {
    return this.inventoryService.createCategory(req.user.schoolId, data);
  }

  @Get('assets')
  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN', 'TEACHER', 'DIRECTOR')
  getAssets(
    @Request() req: any,
    @Query('categoryId') categoryId?: string,
    @Query('status') status?: string,
  ) {
    return this.inventoryService.getAssets(req.user.schoolId, categoryId, status);
  }

  @Post('assets')
  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN')
  createAsset(@Request() req: any, @Body() data: any) {
    return this.inventoryService.createAsset(req.user.schoolId, data);
  }

  @Post('assets/:id/assign')
  @Roles('SUPER_ADMIN', 'SCHOOL_ADMIN')
  assignAsset(@Request() req: any, @Param('id') assetId: string, @Body() data: any) {
    // data should contain { action: 'CHECK_OUT' | 'CHECK_IN', userId: string, notes?: string }
    data.adminId = req.user.userId;
    return this.inventoryService.assignAsset(req.user.schoolId, assetId, data);
  }
}

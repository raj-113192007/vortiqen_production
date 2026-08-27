import { InventoryService } from './inventory.service';
import type { AuthenticatedRequest } from '../common/interfaces/authenticated-request.interface';
export declare class InventoryController {
    private readonly inventoryService;
    constructor(inventoryService: InventoryService);
    getCategories(req: AuthenticatedRequest): Promise<{
        name: string;
        id: string;
        schoolId: string;
        createdAt: Date;
        updatedAt: Date;
        description: string | null;
    }[]>;
    createCategory(req: AuthenticatedRequest, data: {
        name: string;
        description?: string;
    }): Promise<{
        name: string;
        id: string;
        schoolId: string;
        createdAt: Date;
        updatedAt: Date;
        description: string | null;
    }>;
    getAssets(req: AuthenticatedRequest, categoryId?: string, status?: string): Promise<({
        category: {
            name: string;
            id: string;
            schoolId: string;
            createdAt: Date;
            updatedAt: Date;
            description: string | null;
        };
        assignedTo: {
            name: string;
            id: string;
            role: string;
        } | null;
    } & {
        name: string;
        id: string;
        schoolId: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        categoryId: string;
        sku: string | null;
        purchaseDate: Date | null;
        depreciationRate: number | null;
        condition: string;
        assignedToUser: string | null;
        location: string | null;
    })[]>;
    createAsset(req: AuthenticatedRequest, data: {
        categoryId: string;
        name: string;
        sku: string;
        purchaseDate?: string | Date;
        depreciationRate?: string | number;
        status?: string;
        condition?: string;
        location?: string;
    }): Promise<{
        name: string;
        id: string;
        schoolId: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        categoryId: string;
        sku: string | null;
        purchaseDate: Date | null;
        depreciationRate: number | null;
        condition: string;
        assignedToUser: string | null;
        location: string | null;
    }>;
    assignAsset(req: AuthenticatedRequest, assetId: string, data: {
        action: string;
        userId: string;
        notes?: string;
        adminId?: string;
    }): Promise<{
        name: string;
        id: string;
        schoolId: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        categoryId: string;
        sku: string | null;
        purchaseDate: Date | null;
        depreciationRate: number | null;
        condition: string;
        assignedToUser: string | null;
        location: string | null;
    }>;
}

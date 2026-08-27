import { PrismaService } from '../prisma/prisma.service';
export declare class InventoryService {
    private prisma;
    constructor(prisma: PrismaService);
    getCategories(schoolId: string): Promise<{
        name: string;
        id: string;
        schoolId: string;
        createdAt: Date;
        updatedAt: Date;
        description: string | null;
    }[]>;
    createCategory(schoolId: string, data: {
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
    getAssets(schoolId: string, categoryId?: string, status?: string): Promise<({
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
    createAsset(schoolId: string, data: {
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
    assignAsset(schoolId: string, assetId: string, data: {
        action: string;
        userId: string;
        adminId: string;
        notes?: string;
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

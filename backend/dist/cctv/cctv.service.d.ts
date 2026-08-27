import { PrismaService } from '../prisma/prisma.service';
import { Prisma } from '@prisma/client';
export declare class CctvService {
    private prisma;
    constructor(prisma: PrismaService);
    getAllCameras(schoolId: string): Promise<{
        name: string;
        id: string;
        schoolId: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        location: string;
        streamUrl: string;
    }[]>;
    addCamera(schoolId: string, data: {
        name: string;
        location: string;
        streamUrl: string;
        status?: string;
    }): Promise<{
        name: string;
        id: string;
        schoolId: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        location: string;
        streamUrl: string;
    }>;
    updateCamera(id: string, schoolId: string, data: Prisma.CctvCameraUpdateInput): Promise<Prisma.BatchPayload>;
}

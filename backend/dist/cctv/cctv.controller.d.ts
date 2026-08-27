import { CctvService } from './cctv.service';
import type { AuthenticatedRequest } from '../common/interfaces/authenticated-request.interface';
import { Prisma } from '@prisma/client';
export declare class CctvController {
    private readonly cctvService;
    constructor(cctvService: CctvService);
    getAllCameras(req: AuthenticatedRequest): Promise<{
        name: string;
        id: string;
        schoolId: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        location: string;
        streamUrl: string;
    }[]>;
    addCamera(req: AuthenticatedRequest, data: {
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
    updateCamera(id: string, req: AuthenticatedRequest, data: Prisma.CctvCameraUpdateInput): Promise<Prisma.BatchPayload>;
}

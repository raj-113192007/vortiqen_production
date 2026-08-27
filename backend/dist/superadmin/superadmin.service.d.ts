import { PrismaService } from '../prisma/prisma.service';
export declare class SuperadminService {
    private prisma;
    constructor(prisma: PrismaService);
    getStats(): Promise<{
        totalSchools: number;
        totalUsers: number;
        totalStudents: number;
        totalRevenue: number;
    }>;
    getAllSchools(): Promise<({
        _count: {
            students: number;
            users: number;
        };
    } & {
        name: string;
        id: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        deletedAt: Date | null;
        code: string | null;
        address: string | null;
        city: string | null;
        state: string | null;
    })[]>;
    updateSchoolStatus(id: string, status: string): Promise<{
        name: string;
        id: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        deletedAt: Date | null;
        code: string | null;
        address: string | null;
        city: string | null;
        state: string | null;
    }>;
}

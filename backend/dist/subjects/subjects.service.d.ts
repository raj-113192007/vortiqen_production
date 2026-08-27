import { PrismaService } from '../prisma/prisma.service';
import { Prisma } from '@prisma/client';
export declare class SubjectsService {
    private prisma;
    constructor(prisma: PrismaService);
    create(createSubjectDto: Prisma.SubjectUncheckedCreateInput): Promise<{
        teacher: {
            name: string;
            id: string;
            email: string | null;
        } | null;
    } & {
        name: string;
        id: string;
        schoolId: string;
        createdAt: Date;
        updatedAt: Date;
        classId: string;
        teacherId: string | null;
    }>;
    findAll(schoolId: string, classId?: string): Promise<({
        academicClass: {
            name: string;
            id: string;
        };
        teacher: {
            name: string;
            id: string;
            email: string | null;
        } | null;
    } & {
        name: string;
        id: string;
        schoolId: string;
        createdAt: Date;
        updatedAt: Date;
        classId: string;
        teacherId: string | null;
    })[]>;
    findOne(id: string): Promise<{
        academicClass: {
            name: string;
            id: string;
            schoolId: string;
            createdAt: Date;
            updatedAt: Date;
            monthlyFee: number;
        };
        teacher: {
            name: string;
            id: string;
            email: string | null;
        } | null;
    } & {
        name: string;
        id: string;
        schoolId: string;
        createdAt: Date;
        updatedAt: Date;
        classId: string;
        teacherId: string | null;
    }>;
    remove(id: string): Promise<{
        name: string;
        id: string;
        schoolId: string;
        createdAt: Date;
        updatedAt: Date;
        classId: string;
        teacherId: string | null;
    }>;
}

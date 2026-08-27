import { PrismaService } from '../prisma/prisma.service';
import { CreateClassDto } from './dto/create-class.dto';
export declare class AcademicsService {
    private readonly prisma;
    constructor(prisma: PrismaService);
    createClass(schoolId: string, createDto: CreateClassDto): Promise<{
        sections: {
            name: string;
            id: string;
            createdAt: Date;
            updatedAt: Date;
            classId: string;
        }[];
    } & {
        name: string;
        id: string;
        schoolId: string;
        createdAt: Date;
        updatedAt: Date;
        monthlyFee: number;
    }>;
    getClasses(schoolId: string): Promise<({
        sections: {
            name: string;
            id: string;
            createdAt: Date;
            updatedAt: Date;
            classId: string;
        }[];
    } & {
        name: string;
        id: string;
        schoolId: string;
        createdAt: Date;
        updatedAt: Date;
        monthlyFee: number;
    })[]>;
}

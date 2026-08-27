import { PrismaService } from '../prisma/prisma.service';
export declare class StudentsService {
    private prisma;
    constructor(prisma: PrismaService);
    create(createStudentDto: {
        schoolId: string;
        studentUsername: string;
        firstName: string;
        lastName?: string;
        password?: string;
        parentUsername: string;
        classId: string;
        sectionId: string;
        rollNo?: string;
        gender?: string;
    }): Promise<{
        user: {
            id: string;
            username: string | null;
        } | null;
        academicClass: {
            name: string;
            id: string;
        } | null;
        parent: {
            id: string;
            username: string | null;
        } | null;
        section: {
            name: string;
            id: string;
        } | null;
    } & {
        id: string;
        schoolId: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        deletedAt: Date | null;
        rollNo: string | null;
        firstName: string;
        lastName: string | null;
        dob: Date | null;
        gender: string | null;
        classId: string | null;
        userId: string | null;
        parentId: string | null;
        routeId: string | null;
        vehicleId: string | null;
        sectionId: string | null;
    }>;
    findAll(schoolId: string, classId?: string, sectionId?: string, parentId?: string, userId?: string): Promise<({
        user: {
            id: string;
            username: string | null;
            status: string;
        } | null;
        academicClass: {
            name: string;
            id: string;
        } | null;
        parent: {
            id: string;
            username: string | null;
            status: string;
        } | null;
        section: {
            name: string;
            id: string;
        } | null;
    } & {
        id: string;
        schoolId: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        deletedAt: Date | null;
        rollNo: string | null;
        firstName: string;
        lastName: string | null;
        dob: Date | null;
        gender: string | null;
        classId: string | null;
        userId: string | null;
        parentId: string | null;
        routeId: string | null;
        vehicleId: string | null;
        sectionId: string | null;
    })[]>;
    findOne(id: string): Promise<{
        user: {
            id: string;
            username: string | null;
            status: string;
        } | null;
        academicClass: {
            name: string;
            id: string;
            schoolId: string;
            createdAt: Date;
            updatedAt: Date;
            monthlyFee: number;
        } | null;
        parent: {
            id: string;
            username: string | null;
            status: string;
        } | null;
        section: {
            name: string;
            id: string;
            createdAt: Date;
            updatedAt: Date;
            classId: string;
        } | null;
    } & {
        id: string;
        schoolId: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        deletedAt: Date | null;
        rollNo: string | null;
        firstName: string;
        lastName: string | null;
        dob: Date | null;
        gender: string | null;
        classId: string | null;
        userId: string | null;
        parentId: string | null;
        routeId: string | null;
        vehicleId: string | null;
        sectionId: string | null;
    }>;
}

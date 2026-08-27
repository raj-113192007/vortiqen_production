import { PrismaService } from '../prisma/prisma.service';
import { CreateRouteDto, CreateVehicleDto, AssignStudentTransportDto } from './dto/create-transport.dto';
export declare class TransportService {
    private prisma;
    constructor(prisma: PrismaService);
    createRoute(dto: CreateRouteDto, schoolId: string): Promise<{
        name: string;
        id: string;
        schoolId: string;
        createdAt: Date;
        updatedAt: Date;
    }>;
    getRoutes(schoolId: string): Promise<({
        vehicles: ({
            driver: {
                name: string;
                id: string;
                schoolId: string | null;
                username: string | null;
                email: string | null;
                phone: string | null;
                password: string;
                role: string;
                status: string;
                createdAt: Date;
                updatedAt: Date;
                deletedAt: Date | null;
            } | null;
        } & {
            id: string;
            schoolId: string;
            createdAt: Date;
            updatedAt: Date;
            routeId: string | null;
            plateNumber: string;
            capacity: number;
            driverId: string | null;
        })[];
    } & {
        name: string;
        id: string;
        schoolId: string;
        createdAt: Date;
        updatedAt: Date;
    })[]>;
    createVehicle(dto: CreateVehicleDto, schoolId: string): Promise<{
        route: {
            name: string;
            id: string;
            schoolId: string;
            createdAt: Date;
            updatedAt: Date;
        } | null;
        driver: {
            name: string;
            id: string;
            schoolId: string | null;
            username: string | null;
            email: string | null;
            phone: string | null;
            password: string;
            role: string;
            status: string;
            createdAt: Date;
            updatedAt: Date;
            deletedAt: Date | null;
        } | null;
    } & {
        id: string;
        schoolId: string;
        createdAt: Date;
        updatedAt: Date;
        routeId: string | null;
        plateNumber: string;
        capacity: number;
        driverId: string | null;
    }>;
    getVehicles(schoolId: string): Promise<({
        route: {
            name: string;
            id: string;
            schoolId: string;
            createdAt: Date;
            updatedAt: Date;
        } | null;
        driver: {
            name: string;
            id: string;
            schoolId: string | null;
            username: string | null;
            email: string | null;
            phone: string | null;
            password: string;
            role: string;
            status: string;
            createdAt: Date;
            updatedAt: Date;
            deletedAt: Date | null;
        } | null;
    } & {
        id: string;
        schoolId: string;
        createdAt: Date;
        updatedAt: Date;
        routeId: string | null;
        plateNumber: string;
        capacity: number;
        driverId: string | null;
    })[]>;
    assignStudent(dto: AssignStudentTransportDto, schoolId: string): Promise<{
        vehicle: {
            id: string;
            schoolId: string;
            createdAt: Date;
            updatedAt: Date;
            routeId: string | null;
            plateNumber: string;
            capacity: number;
            driverId: string | null;
        } | null;
        route: {
            name: string;
            id: string;
            schoolId: string;
            createdAt: Date;
            updatedAt: Date;
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
    getStudentTransportDetails(studentId: string, schoolId: string): Promise<{
        vehicle: ({
            driver: {
                name: string;
                id: string;
                schoolId: string | null;
                username: string | null;
                email: string | null;
                phone: string | null;
                password: string;
                role: string;
                status: string;
                createdAt: Date;
                updatedAt: Date;
                deletedAt: Date | null;
            } | null;
        } & {
            id: string;
            schoolId: string;
            createdAt: Date;
            updatedAt: Date;
            routeId: string | null;
            plateNumber: string;
            capacity: number;
            driverId: string | null;
        }) | null;
        route: {
            name: string;
            id: string;
            schoolId: string;
            createdAt: Date;
            updatedAt: Date;
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
    getDriverTransportDetails(driverId: string, schoolId: string): Promise<({
        route: {
            name: string;
            id: string;
            schoolId: string;
            createdAt: Date;
            updatedAt: Date;
        } | null;
        students: ({
            academicClass: {
                name: string;
                id: string;
                schoolId: string;
                createdAt: Date;
                updatedAt: Date;
                monthlyFee: number;
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
        })[];
    } & {
        id: string;
        schoolId: string;
        createdAt: Date;
        updatedAt: Date;
        routeId: string | null;
        plateNumber: string;
        capacity: number;
        driverId: string | null;
    }) | null>;
}

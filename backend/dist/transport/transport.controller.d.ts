import { TransportService } from './transport.service';
import { CreateRouteDto, CreateVehicleDto, AssignStudentTransportDto } from './dto/create-transport.dto';
import type { AuthenticatedRequest } from '../common/interfaces/authenticated-request.interface';
export declare class TransportController {
    private readonly transportService;
    constructor(transportService: TransportService);
    createRoute(dto: CreateRouteDto, req: AuthenticatedRequest): Promise<{
        name: string;
        id: string;
        schoolId: string;
        createdAt: Date;
        updatedAt: Date;
    }>;
    getRoutes(req: AuthenticatedRequest): Promise<({
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
    createVehicle(dto: CreateVehicleDto, req: AuthenticatedRequest): Promise<{
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
    getVehicles(req: AuthenticatedRequest): Promise<({
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
    assignStudent(dto: AssignStudentTransportDto, req: AuthenticatedRequest): Promise<{
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
    getStudentTransportDetails(studentId: string, req: AuthenticatedRequest): Promise<{
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
    getDriverTransportDetails(req: AuthenticatedRequest): Promise<({
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

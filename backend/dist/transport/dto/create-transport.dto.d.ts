export declare class CreateRouteDto {
    name: string;
}
export declare class CreateVehicleDto {
    plateNumber: string;
    capacity: number;
    driverId?: string;
    routeId?: string;
}
export declare class AssignStudentTransportDto {
    studentId: string;
    routeId?: string;
    vehicleId?: string;
}

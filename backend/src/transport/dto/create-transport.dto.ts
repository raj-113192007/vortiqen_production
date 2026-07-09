import { IsString, IsNotEmpty, IsNumber, IsOptional } from 'class-validator';

export class CreateRouteDto {
  @IsString()
  @IsNotEmpty()
  name: string;
}

export class CreateVehicleDto {
  @IsString()
  @IsNotEmpty()
  plateNumber: string;

  @IsNumber()
  @IsNotEmpty()
  capacity: number;

  @IsString()
  @IsOptional()
  driverId?: string;

  @IsString()
  @IsOptional()
  routeId?: string;
}

export class AssignStudentTransportDto {
  @IsString()
  @IsNotEmpty()
  studentId: string;

  @IsString()
  @IsOptional()
  routeId?: string;

  @IsString()
  @IsOptional()
  vehicleId?: string;
}

import { IsEmail, IsOptional, IsString } from 'class-validator';

export class CreateUserDto {
  @IsOptional()
  @IsEmail()
  email?: string;

  @IsOptional()
  @IsString()
  username?: string;

  @IsString()
  name: string;

  @IsOptional()
  @IsString()
  password?: string; // Will generate if not provided

  @IsString()
  role: string;

  @IsOptional()
  @IsString()
  phone?: string;

  @IsOptional()
  @IsString()
  schoolId?: string; // Required for non-SuperAdmins
}

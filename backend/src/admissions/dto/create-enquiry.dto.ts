import { IsString, IsNotEmpty, IsOptional, IsEmail } from 'class-validator';

export class CreateEnquiryDto {
  @IsString()
  @IsOptional()
  schoolId?: string;

  @IsString()
  @IsNotEmpty()
  parentName: string;

  @IsString()
  @IsNotEmpty()
  studentName: string;

  @IsEmail()
  @IsOptional()
  email?: string;

  @IsString()
  @IsNotEmpty()
  phone: string;

  @IsString()
  @IsOptional()
  classApplied?: string;

  @IsString()
  @IsOptional()
  notes?: string;
}

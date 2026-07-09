import { IsString, IsNotEmpty, IsOptional, IsDateString, IsNumber, IsArray, ValidateNested } from 'class-validator';
import { Type } from 'class-transformer';

export class CreateExamDto {
  @IsString()
  @IsNotEmpty()
  classId: string;

  @IsString()
  @IsNotEmpty()
  name: string;

  @IsDateString()
  @IsOptional()
  startDate?: string;

  @IsDateString()
  @IsOptional()
  endDate?: string;
}

export class AddExamSubjectDto {
  @IsString()
  @IsNotEmpty()
  subjectId: string;

  @IsDateString()
  @IsOptional()
  examDate?: string;

  @IsNumber()
  @IsOptional()
  maxMarks?: number;
}

export class SubmitExamResultDto {
  @IsString()
  @IsNotEmpty()
  studentId: string;

  @IsNumber()
  @IsOptional()
  marksObtained?: number;

  @IsString()
  @IsOptional()
  grade?: string;

  @IsString()
  @IsOptional()
  remarks?: string;
}

export class BulkSubmitExamResultsDto {
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => SubmitExamResultDto)
  results: SubmitExamResultDto[];
}

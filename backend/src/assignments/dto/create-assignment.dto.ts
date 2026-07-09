import { IsString, IsOptional, IsDateString } from 'class-validator';

export class CreateAssignmentDto {
  @IsString()
  sectionId: string;

  @IsString()
  subjectId: string;

  @IsString()
  title: string;

  @IsOptional()
  @IsString()
  description?: string;

  @IsDateString()
  dueDate: string;
}

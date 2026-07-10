import { PartialType } from '@nestjs/mapped-types';
import { CreateEnquiryDto } from './create-enquiry.dto';
import { IsString, IsOptional, IsDateString } from 'class-validator';

export class UpdateEnquiryDto extends PartialType(CreateEnquiryDto) {
  @IsString()
  @IsOptional()
  status?: string;

  @IsDateString()
  @IsOptional()
  interviewDate?: string;
}

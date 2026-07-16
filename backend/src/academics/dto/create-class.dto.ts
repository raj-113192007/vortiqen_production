import {
  IsString,
  IsNotEmpty,
  IsArray,
  ValidateNested,
  IsNumber,
  IsOptional,
} from 'class-validator';
import { Type } from 'class-transformer';

export class CreateSectionDto {
  @IsString()
  @IsNotEmpty()
  name: string;
}

export class CreateClassDto {
  @IsString()
  @IsNotEmpty()
  name: string;

  @IsNumber()
  @IsOptional()
  monthlyFee?: number;

  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => CreateSectionDto)
  sections: CreateSectionDto[];
}

import { CreateEnquiryDto } from './create-enquiry.dto';
declare const UpdateEnquiryDto_base: import("@nestjs/mapped-types").MappedType<Partial<CreateEnquiryDto>>;
export declare class UpdateEnquiryDto extends UpdateEnquiryDto_base {
    status?: string;
    interviewDate?: string;
}
export {};

import { AdmissionsService } from './admissions.service';
import { CreateEnquiryDto } from './dto/create-enquiry.dto';
import { UpdateEnquiryDto } from './dto/update-enquiry.dto';
import type { AuthenticatedRequest } from '../common/interfaces/authenticated-request.interface';
export declare class AdmissionsController {
    private readonly admissionsService;
    constructor(admissionsService: AdmissionsService);
    createPublicEnquiry(createEnquiryDto: CreateEnquiryDto): Promise<{
        id: string;
        schoolId: string;
        email: string | null;
        phone: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        parentName: string;
        studentName: string;
        classApplied: string | null;
        notes: string | null;
        interviewDate: Date | null;
    }> | {
        success: boolean;
        message: string;
    };
    createEnquiry(req: AuthenticatedRequest, createEnquiryDto: CreateEnquiryDto): Promise<{
        id: string;
        schoolId: string;
        email: string | null;
        phone: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        parentName: string;
        studentName: string;
        classApplied: string | null;
        notes: string | null;
        interviewDate: Date | null;
    }>;
    findAll(req: AuthenticatedRequest, status?: string): Promise<{
        id: string;
        schoolId: string;
        email: string | null;
        phone: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        parentName: string;
        studentName: string;
        classApplied: string | null;
        notes: string | null;
        interviewDate: Date | null;
    }[]>;
    findOne(req: AuthenticatedRequest, id: string): Promise<{
        id: string;
        schoolId: string;
        email: string | null;
        phone: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        parentName: string;
        studentName: string;
        classApplied: string | null;
        notes: string | null;
        interviewDate: Date | null;
    }>;
    update(req: AuthenticatedRequest, id: string, updateEnquiryDto: UpdateEnquiryDto): Promise<{
        id: string;
        schoolId: string;
        email: string | null;
        phone: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        parentName: string;
        studentName: string;
        classApplied: string | null;
        notes: string | null;
        interviewDate: Date | null;
    }>;
}

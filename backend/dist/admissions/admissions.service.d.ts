import { PrismaService } from '../prisma/prisma.service';
import { CreateEnquiryDto } from './dto/create-enquiry.dto';
import { UpdateEnquiryDto } from './dto/update-enquiry.dto';
export declare class AdmissionsService {
    private readonly prisma;
    constructor(prisma: PrismaService);
    createEnquiry(createEnquiryDto: CreateEnquiryDto, schoolId?: string): Promise<{
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
    findAllBySchool(schoolId: string, status?: string): Promise<{
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
    findOne(id: string, schoolId: string): Promise<{
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
    update(id: string, schoolId: string, updateEnquiryDto: UpdateEnquiryDto): Promise<{
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
    private sendInterviewNotification;
}

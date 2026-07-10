import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateEnquiryDto } from './dto/create-enquiry.dto';
import { UpdateEnquiryDto } from './dto/update-enquiry.dto';

@Injectable()
export class AdmissionsService {
  constructor(private readonly prisma: PrismaService) {}

  async createEnquiry(createEnquiryDto: CreateEnquiryDto, schoolId?: string) {
    const targetSchoolId = schoolId || createEnquiryDto.schoolId;
    if (!targetSchoolId) {
      throw new Error('School ID is required');
    }

    return this.prisma.admissionEnquiry.create({
      data: {
        ...createEnquiryDto,
        schoolId: targetSchoolId,
      },
    });
  }

  async findAllBySchool(schoolId: string, status?: string) {
    return this.prisma.admissionEnquiry.findMany({
      where: {
        schoolId,
        ...(status && { status }),
      },
      orderBy: { createdAt: 'desc' },
    });
  }

  async findOne(id: string, schoolId: string) {
    const enquiry = await this.prisma.admissionEnquiry.findUnique({
      where: { id },
    });

    if (!enquiry || enquiry.schoolId !== schoolId) {
      throw new NotFoundException('Enquiry not found');
    }

    return enquiry;
  }

  async update(id: string, schoolId: string, updateEnquiryDto: UpdateEnquiryDto) {
    await this.findOne(id, schoolId);

    const updated = await this.prisma.admissionEnquiry.update({
      where: { id },
      data: updateEnquiryDto,
    });

    if (updateEnquiryDto.status === 'INTERVIEW_SCHEDULED' && updateEnquiryDto.interviewDate) {
      this.sendInterviewNotification(updated);
    }

    return updated;
  }

  private sendInterviewNotification(enquiry: any) {
    // In a real application, integrate with an Email/SMS service here
    console.log(`[Notification] Sending Interview Scheduled SMS/Email to ${enquiry.parentName} at ${enquiry.phone} / ${enquiry.email}`);
    console.log(`[Notification] Interview Date: ${enquiry.interviewDate}`);
  }
}

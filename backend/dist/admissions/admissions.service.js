"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AdmissionsService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
let AdmissionsService = class AdmissionsService {
    prisma;
    constructor(prisma) {
        this.prisma = prisma;
    }
    async createEnquiry(createEnquiryDto, schoolId) {
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
    async findAllBySchool(schoolId, status) {
        return this.prisma.admissionEnquiry.findMany({
            where: {
                schoolId,
                ...(status && { status }),
            },
            orderBy: { createdAt: 'desc' },
        });
    }
    async findOne(id, schoolId) {
        const enquiry = await this.prisma.admissionEnquiry.findUnique({
            where: { id },
        });
        if (!enquiry || enquiry.schoolId !== schoolId) {
            throw new common_1.NotFoundException('Enquiry not found');
        }
        return enquiry;
    }
    async update(id, schoolId, updateEnquiryDto) {
        await this.findOne(id, schoolId);
        const updated = await this.prisma.admissionEnquiry.update({
            where: { id },
            data: updateEnquiryDto,
        });
        if (updateEnquiryDto.status === 'INTERVIEW_SCHEDULED' &&
            updateEnquiryDto.interviewDate) {
            this.sendInterviewNotification(updated);
        }
        return updated;
    }
    sendInterviewNotification(enquiry) {
        console.log(`[Notification] Sending Interview Scheduled SMS/Email to ${enquiry.parentName} at ${enquiry.phone} / ${enquiry.email}`);
        console.log(`[Notification] Interview Date: ${enquiry.interviewDate ? enquiry.interviewDate.toISOString() : 'N/A'}`);
    }
};
exports.AdmissionsService = AdmissionsService;
exports.AdmissionsService = AdmissionsService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], AdmissionsService);
//# sourceMappingURL=admissions.service.js.map
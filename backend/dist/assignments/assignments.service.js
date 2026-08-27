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
exports.AssignmentsService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
let AssignmentsService = class AssignmentsService {
    prisma;
    constructor(prisma) {
        this.prisma = prisma;
    }
    async create(createAssignmentDto, schoolId, teacherId, attachmentUrl) {
        return this.prisma.assignment.create({
            data: {
                schoolId,
                teacherId,
                sectionId: createAssignmentDto.sectionId,
                subjectId: createAssignmentDto.subjectId,
                title: createAssignmentDto.title,
                description: createAssignmentDto.description,
                dueDate: new Date(createAssignmentDto.dueDate),
                attachmentUrl,
            },
        });
    }
    async findAllBySection(sectionId, schoolId) {
        return this.prisma.assignment.findMany({
            where: { sectionId, schoolId },
            include: {
                subject: { select: { name: true } },
                teacher: { select: { name: true } },
            },
            orderBy: { createdAt: 'desc' },
        });
    }
    async findAllByTeacher(teacherId, schoolId) {
        return this.prisma.assignment.findMany({
            where: { teacherId, schoolId },
            include: {
                section: {
                    select: { name: true, academicClass: { select: { name: true } } },
                },
                subject: { select: { name: true } },
            },
            orderBy: { createdAt: 'desc' },
        });
    }
    async submitAssignment(assignmentId, studentId, content, attachmentUrl) {
        return this.prisma.assignmentSubmission.upsert({
            where: {
                assignmentId_studentId: { assignmentId, studentId },
            },
            update: {
                content,
                attachmentUrl,
                status: 'SUBMITTED',
            },
            create: {
                assignmentId,
                studentId,
                content,
                attachmentUrl,
                status: 'SUBMITTED',
            },
        });
    }
    async getSubmissions(assignmentId, schoolId) {
        const assignment = await this.prisma.assignment.findUnique({
            where: { id: assignmentId, schoolId },
        });
        if (!assignment)
            throw new common_1.NotFoundException('Assignment not found');
        return this.prisma.assignmentSubmission.findMany({
            where: { assignmentId },
            include: {
                student: {
                    select: { id: true, firstName: true, lastName: true, rollNo: true },
                },
            },
        });
    }
    async gradeSubmission(submissionId, grade, teacherNotes) {
        return this.prisma.assignmentSubmission.update({
            where: { id: submissionId },
            data: {
                grade,
                teacherNotes,
                status: 'GRADED',
            },
        });
    }
};
exports.AssignmentsService = AssignmentsService;
exports.AssignmentsService = AssignmentsService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], AssignmentsService);
//# sourceMappingURL=assignments.service.js.map
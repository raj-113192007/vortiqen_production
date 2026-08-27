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
exports.ExamsService = void 0;
const common_1 = require("@nestjs/common");
const prisma_service_1 = require("../prisma/prisma.service");
let ExamsService = class ExamsService {
    prisma;
    constructor(prisma) {
        this.prisma = prisma;
    }
    async create(createExamDto, schoolId) {
        return this.prisma.exam.create({
            data: {
                schoolId,
                classId: createExamDto.classId,
                name: createExamDto.name,
                startDate: createExamDto.startDate
                    ? new Date(createExamDto.startDate)
                    : undefined,
                endDate: createExamDto.endDate
                    ? new Date(createExamDto.endDate)
                    : undefined,
            },
            include: {
                academicClass: true,
            },
        });
    }
    async findAllBySchool(schoolId) {
        return this.prisma.exam.findMany({
            where: { schoolId },
            include: {
                academicClass: true,
                examSubjects: {
                    include: {
                        subject: true,
                    },
                },
            },
            orderBy: { createdAt: 'desc' },
        });
    }
    async findOne(id, schoolId) {
        const exam = await this.prisma.exam.findFirst({
            where: { id, schoolId },
            include: {
                academicClass: {
                    include: {
                        sections: true,
                    },
                },
                examSubjects: {
                    include: {
                        subject: true,
                        examResults: {
                            include: {
                                student: true,
                            },
                        },
                    },
                },
            },
        });
        if (!exam)
            throw new common_1.NotFoundException('Exam not found');
        return exam;
    }
    async addExamSubject(examId, dto, schoolId) {
        await this.findOne(examId, schoolId);
        return this.prisma.examSubject.create({
            data: {
                examId,
                subjectId: dto.subjectId,
                examDate: dto.examDate ? new Date(dto.examDate) : undefined,
                maxMarks: dto.maxMarks,
            },
            include: {
                subject: true,
            },
        });
    }
    async bulkSubmitResults(examSubjectId, dto, schoolId) {
        const examSubject = await this.prisma.examSubject.findUnique({
            where: { id: examSubjectId },
            include: { exam: true },
        });
        if (!examSubject || examSubject.exam.schoolId !== schoolId) {
            throw new common_1.NotFoundException('Exam Subject not found');
        }
        const results = [];
        for (const res of dto.results) {
            const result = await this.prisma.examResult.upsert({
                where: {
                    examSubjectId_studentId: {
                        examSubjectId,
                        studentId: res.studentId,
                    },
                },
                update: {
                    marksObtained: res.marksObtained,
                    grade: res.grade,
                    remarks: res.remarks,
                },
                create: {
                    examSubjectId,
                    studentId: res.studentId,
                    marksObtained: res.marksObtained,
                    grade: res.grade,
                    remarks: res.remarks,
                },
            });
            results.push(result);
        }
        return results;
    }
    async getStudentReportCard(studentId, schoolId) {
        const student = await this.prisma.student.findFirst({
            where: { id: studentId, schoolId },
        });
        if (!student)
            throw new common_1.NotFoundException('Student not found');
        const results = await this.prisma.examResult.findMany({
            where: { studentId },
            include: {
                examSubject: {
                    include: {
                        exam: true,
                        subject: true,
                    },
                },
            },
        });
        const examsMap = new Map();
        for (const res of results) {
            const exam = res.examSubject.exam;
            if (!examsMap.has(exam.id)) {
                examsMap.set(exam.id, {
                    id: exam.id,
                    name: exam.name,
                    startDate: exam.startDate,
                    endDate: exam.endDate,
                    status: exam.status,
                    subjects: [],
                });
            }
            examsMap.get(exam.id).subjects.push({
                subjectName: res.examSubject.subject.name,
                maxMarks: res.examSubject.maxMarks,
                examDate: res.examSubject.examDate,
                marksObtained: res.marksObtained,
                grade: res.grade,
                remarks: res.remarks,
            });
        }
        return Array.from(examsMap.values());
    }
};
exports.ExamsService = ExamsService;
exports.ExamsService = ExamsService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], ExamsService);
//# sourceMappingURL=exams.service.js.map
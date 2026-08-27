import { CreateExamDto, AddExamSubjectDto, BulkSubmitExamResultsDto } from './dto/create-exam.dto';
import { PrismaService } from '../prisma/prisma.service';
export declare class ExamsService {
    private prisma;
    constructor(prisma: PrismaService);
    create(createExamDto: CreateExamDto, schoolId: string): Promise<{
        academicClass: {
            name: string;
            id: string;
            schoolId: string;
            createdAt: Date;
            updatedAt: Date;
            monthlyFee: number;
        };
    } & {
        name: string;
        id: string;
        schoolId: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        classId: string;
        startDate: Date | null;
        endDate: Date | null;
    }>;
    findAllBySchool(schoolId: string): Promise<({
        academicClass: {
            name: string;
            id: string;
            schoolId: string;
            createdAt: Date;
            updatedAt: Date;
            monthlyFee: number;
        };
        examSubjects: ({
            subject: {
                name: string;
                id: string;
                schoolId: string;
                createdAt: Date;
                updatedAt: Date;
                classId: string;
                teacherId: string | null;
            };
        } & {
            id: string;
            createdAt: Date;
            updatedAt: Date;
            subjectId: string;
            examDate: Date | null;
            maxMarks: number;
            examId: string;
        })[];
    } & {
        name: string;
        id: string;
        schoolId: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        classId: string;
        startDate: Date | null;
        endDate: Date | null;
    })[]>;
    findOne(id: string, schoolId: string): Promise<{
        academicClass: {
            sections: {
                name: string;
                id: string;
                createdAt: Date;
                updatedAt: Date;
                classId: string;
            }[];
        } & {
            name: string;
            id: string;
            schoolId: string;
            createdAt: Date;
            updatedAt: Date;
            monthlyFee: number;
        };
        examSubjects: ({
            subject: {
                name: string;
                id: string;
                schoolId: string;
                createdAt: Date;
                updatedAt: Date;
                classId: string;
                teacherId: string | null;
            };
            examResults: ({
                student: {
                    id: string;
                    schoolId: string;
                    status: string;
                    createdAt: Date;
                    updatedAt: Date;
                    deletedAt: Date | null;
                    rollNo: string | null;
                    firstName: string;
                    lastName: string | null;
                    dob: Date | null;
                    gender: string | null;
                    classId: string | null;
                    userId: string | null;
                    parentId: string | null;
                    routeId: string | null;
                    vehicleId: string | null;
                    sectionId: string | null;
                };
            } & {
                id: string;
                createdAt: Date;
                updatedAt: Date;
                studentId: string;
                remarks: string | null;
                grade: string | null;
                marksObtained: number | null;
                examSubjectId: string;
            })[];
        } & {
            id: string;
            createdAt: Date;
            updatedAt: Date;
            subjectId: string;
            examDate: Date | null;
            maxMarks: number;
            examId: string;
        })[];
    } & {
        name: string;
        id: string;
        schoolId: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        classId: string;
        startDate: Date | null;
        endDate: Date | null;
    }>;
    addExamSubject(examId: string, dto: AddExamSubjectDto, schoolId: string): Promise<{
        subject: {
            name: string;
            id: string;
            schoolId: string;
            createdAt: Date;
            updatedAt: Date;
            classId: string;
            teacherId: string | null;
        };
    } & {
        id: string;
        createdAt: Date;
        updatedAt: Date;
        subjectId: string;
        examDate: Date | null;
        maxMarks: number;
        examId: string;
    }>;
    bulkSubmitResults(examSubjectId: string, dto: BulkSubmitExamResultsDto, schoolId: string): Promise<{
        id: string;
        createdAt: Date;
        updatedAt: Date;
        studentId: string;
        remarks: string | null;
        grade: string | null;
        marksObtained: number | null;
        examSubjectId: string;
    }[]>;
    getStudentReportCard(studentId: string, schoolId: string): Promise<{
        id: string;
        name: string;
        startDate: Date | null;
        endDate: Date | null;
        status: string;
        subjects: {
            subjectName: string;
            maxMarks: number;
            examDate: Date | null;
            marksObtained: number | null;
            grade: string | null;
            remarks: string | null;
        }[];
    }[]>;
}

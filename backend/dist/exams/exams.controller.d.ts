import { ExamsService } from './exams.service';
import { CreateExamDto, AddExamSubjectDto, BulkSubmitExamResultsDto } from './dto/create-exam.dto';
import type { AuthenticatedRequest } from '../common/interfaces/authenticated-request.interface';
export declare class ExamsController {
    private readonly examsService;
    constructor(examsService: ExamsService);
    create(createExamDto: CreateExamDto, req: AuthenticatedRequest): Promise<{
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
    findAll(req: AuthenticatedRequest): Promise<({
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
    findOne(id: string, req: AuthenticatedRequest): Promise<{
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
    addExamSubject(id: string, dto: AddExamSubjectDto, req: AuthenticatedRequest): Promise<{
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
    bulkSubmitResults(subjectId: string, dto: BulkSubmitExamResultsDto, req: AuthenticatedRequest): Promise<{
        id: string;
        createdAt: Date;
        updatedAt: Date;
        studentId: string;
        remarks: string | null;
        grade: string | null;
        marksObtained: number | null;
        examSubjectId: string;
    }[]>;
    getStudentReportCard(studentId: string, req: AuthenticatedRequest): Promise<{
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

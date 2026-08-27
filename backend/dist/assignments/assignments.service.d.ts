import { PrismaService } from '../prisma/prisma.service';
import { CreateAssignmentDto } from './dto/create-assignment.dto';
export declare class AssignmentsService {
    private prisma;
    constructor(prisma: PrismaService);
    create(createAssignmentDto: CreateAssignmentDto, schoolId: string, teacherId: string, attachmentUrl?: string): Promise<{
        id: string;
        schoolId: string;
        createdAt: Date;
        updatedAt: Date;
        sectionId: string;
        title: string;
        description: string | null;
        attachmentUrl: string | null;
        dueDate: Date;
        subjectId: string;
        teacherId: string;
    }>;
    findAllBySection(sectionId: string, schoolId: string): Promise<({
        subject: {
            name: string;
        };
        teacher: {
            name: string;
        };
    } & {
        id: string;
        schoolId: string;
        createdAt: Date;
        updatedAt: Date;
        sectionId: string;
        title: string;
        description: string | null;
        attachmentUrl: string | null;
        dueDate: Date;
        subjectId: string;
        teacherId: string;
    })[]>;
    findAllByTeacher(teacherId: string, schoolId: string): Promise<({
        subject: {
            name: string;
        };
        section: {
            academicClass: {
                name: string;
            };
            name: string;
        };
    } & {
        id: string;
        schoolId: string;
        createdAt: Date;
        updatedAt: Date;
        sectionId: string;
        title: string;
        description: string | null;
        attachmentUrl: string | null;
        dueDate: Date;
        subjectId: string;
        teacherId: string;
    })[]>;
    submitAssignment(assignmentId: string, studentId: string, content?: string, attachmentUrl?: string): Promise<{
        id: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        attachmentUrl: string | null;
        studentId: string;
        assignmentId: string;
        content: string | null;
        grade: string | null;
        teacherNotes: string | null;
    }>;
    getSubmissions(assignmentId: string, schoolId: string): Promise<({
        student: {
            id: string;
            rollNo: string | null;
            firstName: string;
            lastName: string | null;
        };
    } & {
        id: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        attachmentUrl: string | null;
        studentId: string;
        assignmentId: string;
        content: string | null;
        grade: string | null;
        teacherNotes: string | null;
    })[]>;
    gradeSubmission(submissionId: string, grade: string, teacherNotes?: string): Promise<{
        id: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        attachmentUrl: string | null;
        studentId: string;
        assignmentId: string;
        content: string | null;
        grade: string | null;
        teacherNotes: string | null;
    }>;
}

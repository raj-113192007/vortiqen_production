import { AssignmentsService } from './assignments.service';
import { CreateAssignmentDto } from './dto/create-assignment.dto';
import type { AuthenticatedRequest } from '../common/interfaces/authenticated-request.interface';
export declare class AssignmentsController {
    private readonly assignmentsService;
    constructor(assignmentsService: AssignmentsService);
    create(createAssignmentDto: CreateAssignmentDto, req: AuthenticatedRequest, file?: Express.Multer.File): Promise<{
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
    findAllBySection(sectionId: string, req: AuthenticatedRequest): Promise<({
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
    findAllByTeacher(req: AuthenticatedRequest): Promise<({
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
    submitAssignment(id: string, studentId: string, content?: string, file?: Express.Multer.File): Promise<{
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
    getSubmissions(id: string, req: AuthenticatedRequest): Promise<({
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

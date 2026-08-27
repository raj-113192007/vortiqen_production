import { AttendanceService } from './attendance.service';
export declare class AttendanceController {
    private readonly attendanceService;
    constructor(attendanceService: AttendanceService);
    markAttendance(schoolId: string, body: {
        date: string;
        studentStatuses: {
            studentId: string;
            status: string;
            remarks?: string;
        }[];
        markedById: string;
    }): Promise<{
        success: boolean;
        count: number;
    }>;
    getAttendanceByClass(schoolId: string, classId: string, sectionId: string, date: string): Promise<({
        student: {
            id: string;
            rollNo: string | null;
            firstName: string;
            lastName: string | null;
        };
    } & {
        id: string;
        schoolId: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        studentId: string;
        date: Date;
        markedById: string | null;
        remarks: string | null;
    })[]>;
    getAttendanceByStudent(schoolId: string, studentId: string): Promise<{
        id: string;
        schoolId: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        studentId: string;
        date: Date;
        markedById: string | null;
        remarks: string | null;
    }[]>;
}

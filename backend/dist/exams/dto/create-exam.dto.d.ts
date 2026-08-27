export declare class CreateExamDto {
    classId: string;
    name: string;
    startDate?: string;
    endDate?: string;
}
export declare class AddExamSubjectDto {
    subjectId: string;
    examDate?: string;
    maxMarks?: number;
}
export declare class SubmitExamResultDto {
    studentId: string;
    marksObtained?: number;
    grade?: string;
    remarks?: string;
}
export declare class BulkSubmitExamResultsDto {
    results: SubmitExamResultDto[];
}

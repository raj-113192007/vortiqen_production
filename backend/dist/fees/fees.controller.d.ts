import { FeesService } from './fees.service';
export declare class FeesController {
    private readonly feesService;
    constructor(feesService: FeesService);
    createCategory(schoolId: string, body: {
        name: string;
        amount: number;
    }): Promise<{
        name: string;
        id: string;
        schoolId: string;
        createdAt: Date;
        updatedAt: Date;
        amount: number;
    }>;
    getCategories(schoolId: string): Promise<{
        name: string;
        id: string;
        schoolId: string;
        createdAt: Date;
        updatedAt: Date;
        amount: number;
    }[]>;
    generateLedgers(schoolId: string, body: {
        categoryId: string;
        dueDate: string;
        classId?: string;
    }): Promise<{
        success: boolean;
        count: number;
    }>;
    getLedgers(schoolId: string, classId?: string, sectionId?: string): Promise<({
        student: {
            user: {
                name: string;
            } | null;
            id: string;
            rollNo: string | null;
            firstName: string;
            lastName: string | null;
        };
        category: {
            name: string;
            id: string;
            schoolId: string;
            createdAt: Date;
            updatedAt: Date;
            amount: number;
        };
    } & {
        id: string;
        schoolId: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        dueDate: Date;
        studentId: string;
        categoryId: string;
        amountDue: number;
        amountPaid: number;
    })[]>;
    recordPayment(schoolId: string, body: {
        ledgerId: string;
        amountPaid: number;
        paymentMethod: string;
        receiptNo?: string;
    }): Promise<{
        payment: {
            id: string;
            schoolId: string;
            createdAt: Date;
            updatedAt: Date;
            studentId: string;
            amountPaid: number;
            paymentDate: Date;
            paymentMethod: string;
            receiptNo: string | null;
            ledgerId: string;
        };
        ledger: {
            id: string;
            schoolId: string;
            status: string;
            createdAt: Date;
            updatedAt: Date;
            dueDate: Date;
            studentId: string;
            categoryId: string;
            amountDue: number;
            amountPaid: number;
        };
    }>;
}

import { PrismaService } from '../prisma/prisma.service';
export declare class HrService {
    private prisma;
    constructor(prisma: PrismaService);
    findAllEmployees(schoolId: string): Promise<({
        user: {
            name: string;
            email: string | null;
            phone: string | null;
            role: string;
        };
    } & {
        id: string;
        schoolId: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        userId: string;
        designation: string;
        department: string | null;
        baseSalary: number;
        joinDate: Date;
    })[]>;
    getMyEmployeeProfile(userId: string): Promise<{
        user: {
            name: string;
            email: string | null;
            phone: string | null;
            role: string;
        };
    } & {
        id: string;
        schoolId: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        userId: string;
        designation: string;
        department: string | null;
        baseSalary: number;
        joinDate: Date;
    }>;
    createEmployee(schoolId: string, data: {
        userId: string;
        designation?: string;
        department?: string;
        baseSalary?: string | number;
        joinDate?: string | Date;
    }): Promise<{
        id: string;
        schoolId: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        userId: string;
        designation: string;
        department: string | null;
        baseSalary: number;
        joinDate: Date;
    }>;
    findPayrolls(schoolId: string, month: number, year: number): Promise<({
        employee: {
            user: {
                name: string;
            };
        } & {
            id: string;
            schoolId: string;
            status: string;
            createdAt: Date;
            updatedAt: Date;
            userId: string;
            designation: string;
            department: string | null;
            baseSalary: number;
            joinDate: Date;
        };
    } & {
        id: string;
        schoolId: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        year: number;
        paymentDate: Date | null;
        month: number;
        baseSalary: number;
        employeeId: string;
        allowances: number;
        deductions: number;
        netPay: number;
    })[]>;
    getMyPayrolls(userId: string): Promise<({
        employee: {
            user: {
                name: string;
                role: string;
            };
        } & {
            id: string;
            schoolId: string;
            status: string;
            createdAt: Date;
            updatedAt: Date;
            userId: string;
            designation: string;
            department: string | null;
            baseSalary: number;
            joinDate: Date;
        };
    } & {
        id: string;
        schoolId: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        year: number;
        paymentDate: Date | null;
        month: number;
        baseSalary: number;
        employeeId: string;
        allowances: number;
        deductions: number;
        netPay: number;
    })[]>;
    generatePayroll(schoolId: string, month: number, year: number): Promise<{
        generatedCount: number;
        payrolls: {
            id: string;
            schoolId: string;
            status: string;
            createdAt: Date;
            updatedAt: Date;
            year: number;
            paymentDate: Date | null;
            month: number;
            baseSalary: number;
            employeeId: string;
            allowances: number;
            deductions: number;
            netPay: number;
        }[];
    }>;
    markAsPaid(schoolId: string, payrollId: string): Promise<{
        id: string;
        schoolId: string;
        status: string;
        createdAt: Date;
        updatedAt: Date;
        year: number;
        paymentDate: Date | null;
        month: number;
        baseSalary: number;
        employeeId: string;
        allowances: number;
        deductions: number;
        netPay: number;
    }>;
}

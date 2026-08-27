import { HrService } from './hr.service';
import type { AuthenticatedRequest } from '../common/interfaces/authenticated-request.interface';
export declare class HrController {
    private readonly hrService;
    constructor(hrService: HrService);
    findAllEmployees(req: AuthenticatedRequest): Promise<({
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
    getMyEmployeeProfile(req: AuthenticatedRequest): Promise<{
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
    createEmployee(req: AuthenticatedRequest, createEmployeeDto: {
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
    findPayrolls(req: AuthenticatedRequest, month: string, year: string): Promise<({
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
    getMyPayrolls(req: AuthenticatedRequest): Promise<({
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
    generatePayroll(req: AuthenticatedRequest, data: {
        month: number;
        year: number;
    }): Promise<{
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
    markAsPaid(req: AuthenticatedRequest, id: string): Promise<{
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

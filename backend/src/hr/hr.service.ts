import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class HrService {
  constructor(private prisma: PrismaService) {}

  async findAllEmployees(schoolId: string) {
    return this.prisma.employee.findMany({
      where: { schoolId },
      include: {
        user: {
          select: { name: true, email: true, phone: true, role: true }
        }
      },
    });
  }

  async getMyEmployeeProfile(userId: string) {
    const employee = await this.prisma.employee.findUnique({
      where: { userId },
      include: {
        user: {
          select: { name: true, email: true, phone: true, role: true }
        }
      },
    });
    if (!employee) throw new NotFoundException('Employee profile not found');
    return employee;
  }

  async createEmployee(schoolId: string, data: any) {
    // Check if user exists
    const user = await this.prisma.user.findFirst({
      where: { id: data.userId, schoolId }
    });
    if (!user) throw new NotFoundException('User not found in this school');

    // Ensure they don't already have an employee profile
    const existing = await this.prisma.employee.findUnique({
      where: { userId: data.userId }
    });
    if (existing) throw new BadRequestException('User already has an employee profile');

    return this.prisma.employee.create({
      data: {
        schoolId,
        userId: data.userId,
        designation: data.designation,
        department: data.department,
        baseSalary: data.baseSalary ? parseFloat(data.baseSalary.toString()) : 0,
        joinDate: data.joinDate ? new Date(data.joinDate) : new Date(),
      }
    });
  }

  async findPayrolls(schoolId: string, month: number, year: number) {
    return this.prisma.payroll.findMany({
      where: { schoolId, month, year },
      include: {
        employee: {
          include: {
            user: {
              select: { name: true }
            }
          }
        }
      }
    });
  }

  async getMyPayrolls(userId: string) {
    const employee = await this.prisma.employee.findUnique({
      where: { userId }
    });
    if (!employee) return [];

    return this.prisma.payroll.findMany({
      where: { employeeId: employee.id },
      orderBy: [
        { year: 'desc' },
        { month: 'desc' },
      ],
      include: {
        employee: {
          include: {
            user: {
              select: { name: true, role: true }
            }
          }
        }
      }
    });
  }

  async generatePayroll(schoolId: string, month: number, year: number) {
    const activeEmployees = await this.prisma.employee.findMany({
      where: { schoolId, status: 'ACTIVE' }
    });

    const generated = [];
    for (const emp of activeEmployees) {
      // Check if payroll already exists for this month/year
      const existing = await this.prisma.payroll.findFirst({
        where: { schoolId, employeeId: emp.id, month, year }
      });
      if (existing) continue;

      const payroll = await this.prisma.payroll.create({
        data: {
          schoolId,
          employeeId: emp.id,
          month,
          year,
          baseSalary: emp.baseSalary,
          allowances: 0,
          deductions: 0,
          netPay: emp.baseSalary, // baseSalary + allowances - deductions
          status: 'PENDING'
        }
      });
      generated.push(payroll);
    }
    return { generatedCount: generated.length, payrolls: generated };
  }

  async markAsPaid(schoolId: string, payrollId: string) {
    const payroll = await this.prisma.payroll.findFirst({
      where: { id: payrollId, schoolId }
    });
    if (!payroll) throw new NotFoundException('Payroll not found');
    if (payroll.status === 'PAID') throw new BadRequestException('Payroll is already marked as paid');

    return this.prisma.payroll.update({
      where: { id: payrollId },
      data: {
        status: 'PAID',
        paymentDate: new Date(),
      }
    });
  }
}

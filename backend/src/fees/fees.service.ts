import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { Prisma } from '@prisma/client';

@Injectable()
export class FeesService {
  constructor(private prisma: PrismaService) {}

  async createCategory(schoolId: string, name: string, amount: number) {
    return this.prisma.feeCategory.create({
      data: { schoolId, name, amount },
    });
  }

  async getCategories(schoolId: string) {
    return this.prisma.feeCategory.findMany({ where: { schoolId } });
  }

  async generateLedgers(
    schoolId: string,
    categoryId: string,
    dueDate: string,
    classId?: string,
  ) {
    // Basic implementation: assign fee to all students in a class or all students
    const whereClause: Prisma.StudentWhereInput = {
      schoolId,
      status: 'ENROLLED',
    };
    if (classId) {
      whereClause.classId = classId;
    }

    const students = await this.prisma.student.findMany({
      where: whereClause,
      include: { academicClass: true },
    });
    const category = await this.prisma.feeCategory.findUnique({
      where: { id: categoryId },
    });

    if (!category) {
      throw new NotFoundException('Fee category not found');
    }

    const isTuition = category.name.toLowerCase().includes('tuition');

    const ledgers = await this.prisma.$transaction(
      students.map((student) => {
        const classFee = student.academicClass?.monthlyFee;
        const amountDue =
          isTuition && classFee && classFee > 0 ? classFee : category.amount;

        return this.prisma.feeLedger.create({
          data: {
            schoolId,
            studentId: student.id,
            categoryId,
            dueDate: new Date(dueDate),
            amountDue,
          },
        });
      }),
    );

    return { success: true, count: ledgers.length };
  }

  async getLedgers(schoolId: string, classId?: string, sectionId?: string) {
    const whereClause: Prisma.FeeLedgerWhereInput = { schoolId };

    if (classId || sectionId) {
      whereClause.student = {};
      if (classId) whereClause.student.classId = classId;
      if (sectionId) whereClause.student.sectionId = sectionId;
    }

    return this.prisma.feeLedger.findMany({
      where: whereClause,
      include: {
        student: {
          select: {
            id: true,
            rollNo: true,
            firstName: true,
            lastName: true,
            user: { select: { name: true } },
          },
        },
        category: true,
      },
      orderBy: { dueDate: 'asc' },
    });
  }

  async recordPayment(
    schoolId: string,
    ledgerId: string,
    amountPaid: number,
    paymentMethod: string,
    receiptNo?: string,
  ) {
    const ledger = await this.prisma.feeLedger.findUnique({
      where: { id: ledgerId },
    });
    if (!ledger) throw new NotFoundException('Ledger not found');

    const newAmountPaid = ledger.amountPaid + amountPaid;
    let status = ledger.status;

    if (newAmountPaid >= ledger.amountDue) {
      status = 'PAID';
    } else if (newAmountPaid > 0) {
      status = 'PARTIAL';
    }

    return this.prisma.$transaction(async (prisma) => {
      const payment = await prisma.feePayment.create({
        data: {
          schoolId,
          ledgerId,
          studentId: ledger.studentId,
          amountPaid,
          paymentMethod,
          receiptNo,
        },
      });

      const updatedLedger = await prisma.feeLedger.update({
        where: { id: ledgerId },
        data: {
          amountPaid: newAmountPaid,
          status,
        },
      });

      return { payment, ledger: updatedLedger };
    });
  }
}

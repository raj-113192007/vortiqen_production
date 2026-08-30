class SubjectAllocation {
  final String subject;
  final String classes;
  final String periods;

  const SubjectAllocation({
    required this.subject,
    required this.classes,
    required this.periods,
  });
}

class PayslipRecord {
  final String month;
  final String amount;
  final String status;
  final String ref;

  const PayslipRecord({
    required this.month,
    required this.amount,
    required this.status,
    required this.ref,
  });
}

class ScheduleSlot {
  final String time;
  final String task;
  final String room;
  final String type; // 'TEACHING', 'CLASS_TEACHER', 'LIVE'

  const ScheduleSlot({
    required this.time,
    required this.task,
    required this.room,
    required this.type,
  });
}

class TeacherProfile {
  final String id;
  final String empId;
  final String name;
  final String designation;
  final String department;
  final String email;
  final String phone;
  final String bloodGroup;
  final String dob;
  final String gender;
  final String joiningDate;
  final String experience;
  final String qualifications;
  final String address;

  // Class Teacher & Subjects
  final String classTeacherOf;
  final String roomNumber;
  final List<SubjectAllocation> subjectsTaught;
  final int weeklyPeriods;

  // Salary & Payroll
  final double baseSalary;
  final double allowances;
  final double deductions;
  final double netSalary;
  final String payrollStatus;
  final String bankAccount;
  final List<PayslipRecord> payslipHistory;

  // Attendance
  final double attendancePct;
  final int totalDays;
  final int presentDays;
  final int leavesTaken;
  final int remainingLeaves;
  final String todayStatus; // 'Present', 'On Leave'

  // Timetable & Rating
  final List<ScheduleSlot> dailySchedule;
  final double rating;

  const TeacherProfile({
    required this.id,
    required this.empId,
    required this.name,
    required this.designation,
    required this.department,
    required this.email,
    required this.phone,
    required this.bloodGroup,
    required this.dob,
    required this.gender,
    required this.joiningDate,
    required this.experience,
    required this.qualifications,
    required this.address,
    required this.classTeacherOf,
    required this.roomNumber,
    required this.subjectsTaught,
    required this.weeklyPeriods,
    required this.baseSalary,
    required this.allowances,
    required this.deductions,
    required this.netSalary,
    required this.payrollStatus,
    required this.bankAccount,
    required this.payslipHistory,
    required this.attendancePct,
    required this.totalDays,
    required this.presentDays,
    required this.leavesTaken,
    required this.remainingLeaves,
    required this.todayStatus,
    required this.dailySchedule,
    required this.rating,
  });

  bool get isPresentToday => todayStatus.toLowerCase().contains('present');
}

class StaffMockData {
  static List<TeacherProfile> getTeachers() {
    return [
      const TeacherProfile(
        id: 'tch_01',
        empId: 'EMP-2021-084',
        name: 'Dr. Priya Verma',
        designation: 'Senior Faculty & HOD Science',
        department: 'Science & Math',
        email: 'priya.verma@school.edu',
        phone: '+91 98111 22334',
        bloodGroup: 'O+',
        dob: '12 Nov 1984',
        gender: 'Female',
        joiningDate: '15 June 2021',
        experience: '14 Yrs (5 Yrs at DPIS)',
        qualifications: 'Ph.D Physics (DU), M.Sc, B.Ed',
        address: 'B-402, Faculty Enclave, New Delhi',
        classTeacherOf: 'Class 10-A',
        roomNumber: 'Room 204',
        subjectsTaught: [
          SubjectAllocation(subject: 'Physics & Mechanics', classes: 'Class 10-A, 12-A', periods: '16 P/wk'),
          SubjectAllocation(subject: 'Advanced Math', classes: 'Class 10-A, 11-Sci', periods: '12 P/wk'),
        ],
        weeklyPeriods: 28,
        baseSalary: 65000,
        allowances: 8500,
        deductions: 4000,
        netSalary: 69500,
        payrollStatus: 'Disbursed (August)',
        bankAccount: 'HDFC Bank (A/C: XXXX-8849)',
        payslipHistory: [
          PayslipRecord(month: 'August 2026', amount: '₹ 69,500', status: 'Disbursed', ref: 'PAY_AUG_8849'),
          PayslipRecord(month: 'July 2026', amount: '₹ 69,500', status: 'Disbursed', ref: 'PAY_JUL_8812'),
        ],
        attendancePct: 97.6,
        totalDays: 84,
        presentDays: 82,
        leavesTaken: 2,
        remainingLeaves: 10,
        todayStatus: 'Present',
        dailySchedule: [
          ScheduleSlot(time: '08:30 - 09:15', task: 'Class 10-A Homeroom', room: 'Room 204', type: 'CLASS_TEACHER'),
          ScheduleSlot(time: '09:15 - 10:00', task: 'Class 12-A Physics', room: 'Room 302', type: 'TEACHING'),
          ScheduleSlot(time: '10:30 - 11:15', task: 'Class 10-A Physics Lab', room: 'Lab 2', type: 'LIVE'),
        ],
        rating: 4.9,
      ),
      const TeacherProfile(
        id: 'tch_02',
        empId: 'EMP-2022-098',
        name: 'Prof. Alok Mukherjee',
        designation: 'HOD Mathematics',
        department: 'Science & Math',
        email: 'alok.mukherjee@school.edu',
        phone: '+91 98222 33445',
        bloodGroup: 'B+',
        dob: '05 Aug 1980',
        gender: 'Male',
        joiningDate: '10 July 2022',
        experience: '18 Yrs Total',
        qualifications: 'M.Sc Applied Mathematics, B.Ed',
        address: 'Sector 14, Rohini, New Delhi',
        classTeacherOf: 'Class 12-Science',
        roomNumber: 'Room 305',
        subjectsTaught: [
          SubjectAllocation(subject: 'Calculus & Algebra', classes: 'Class 11-Sci, 12-Sci', periods: '20 P/wk'),
        ],
        weeklyPeriods: 26,
        baseSalary: 72000,
        allowances: 9000,
        deductions: 5000,
        netSalary: 76000,
        payrollStatus: 'Disbursed (August)',
        bankAccount: 'SBI (A/C: XXXX-4412)',
        payslipHistory: [
          PayslipRecord(month: 'August 2026', amount: '₹ 76,000', status: 'Disbursed', ref: 'PAY_AUG_4412'),
        ],
        attendancePct: 98.8,
        totalDays: 84,
        presentDays: 83,
        leavesTaken: 1,
        remainingLeaves: 11,
        todayStatus: 'Present',
        dailySchedule: [
          ScheduleSlot(time: '08:30 - 09:15', task: 'Class 12-Sci Homeroom', room: 'Room 305', type: 'CLASS_TEACHER'),
          ScheduleSlot(time: '10:00 - 10:45', task: 'Class 11-Sci Calculus', room: 'Room 301', type: 'TEACHING'),
        ],
        rating: 4.8,
      ),
      const TeacherProfile(
        id: 'tch_03',
        empId: 'EMP-2023-112',
        name: 'Ms. Sunita Roy',
        designation: 'Senior Faculty English Literature',
        department: 'Humanities & Languages',
        email: 'sunita.roy@school.edu',
        phone: '+91 98333 44556',
        bloodGroup: 'A+',
        dob: '22 Mar 1989',
        gender: 'Female',
        joiningDate: '01 April 2023',
        experience: '9 Yrs Total',
        qualifications: 'M.A. English Literature, B.Ed (Gold Medalist)',
        address: 'Dwarka Sector 10, New Delhi',
        classTeacherOf: 'Class 9-B',
        roomNumber: 'Room 108',
        subjectsTaught: [
          SubjectAllocation(subject: 'English Core & Grammar', classes: 'Class 9-B, 10-B, 11-Arts', periods: '22 P/wk'),
        ],
        weeklyPeriods: 24,
        baseSalary: 55000,
        allowances: 6500,
        deductions: 3500,
        netSalary: 58000,
        payrollStatus: 'Disbursed (August)',
        bankAccount: 'ICICI Bank (A/C: XXXX-9901)',
        payslipHistory: [
          PayslipRecord(month: 'August 2026', amount: '₹ 58,000', status: 'Disbursed', ref: 'PAY_AUG_9901'),
        ],
        attendancePct: 94.2,
        totalDays: 84,
        presentDays: 79,
        leavesTaken: 5,
        remainingLeaves: 7,
        todayStatus: 'On Leave',
        dailySchedule: [],
        rating: 4.7,
      ),
      const TeacherProfile(
        id: 'tch_04',
        empId: 'EMP-2024-142',
        name: 'Mr. Rajeshwar Rao',
        designation: 'Faculty Computer Science & AI',
        department: 'IT & Computer Science',
        email: 'rajeshwar.rao@school.edu',
        phone: '+91 98444 55667',
        bloodGroup: 'AB+',
        dob: '18 Sep 1992',
        gender: 'Male',
        joiningDate: '15 Jan 2024',
        experience: '6 Yrs Total',
        qualifications: 'B.Tech CSE, M.Tech Data Science',
        address: 'Janakpuri C-Block, New Delhi',
        classTeacherOf: 'Class 11-CS',
        roomNumber: 'Computer Lab 1',
        subjectsTaught: [
          SubjectAllocation(subject: 'Python & Data Structures', classes: 'Class 11-CS, 12-CS', periods: '18 P/wk'),
          SubjectAllocation(subject: 'Web Technologies', classes: 'Class 9-A, 10-A', periods: '10 P/wk'),
        ],
        weeklyPeriods: 28,
        baseSalary: 58000,
        allowances: 7000,
        deductions: 3500,
        netSalary: 61500,
        payrollStatus: 'Disbursed (August)',
        bankAccount: 'Axis Bank (A/C: XXXX-2219)',
        payslipHistory: [
          PayslipRecord(month: 'August 2026', amount: '₹ 61,500', status: 'Disbursed', ref: 'PAY_AUG_2219'),
        ],
        attendancePct: 99.0,
        totalDays: 84,
        presentDays: 83,
        leavesTaken: 1,
        remainingLeaves: 11,
        todayStatus: 'Present',
        dailySchedule: [
          ScheduleSlot(time: '09:15 - 10:00', task: 'Class 11-CS Python Lab', room: 'Lab 1', type: 'TEACHING'),
          ScheduleSlot(time: '11:15 - 12:00', task: 'Class 12-CS SQL & Backend', room: 'Lab 1', type: 'TEACHING'),
        ],
        rating: 4.9,
      ),
    ];
  }
}

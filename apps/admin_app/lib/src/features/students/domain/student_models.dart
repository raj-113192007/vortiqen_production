class SubjectMark {
  final String subject;
  final int marks;
  final int maxMarks;
  final String grade;
  final String teacher;

  const SubjectMark({
    required this.subject,
    required this.marks,
    required this.maxMarks,
    required this.grade,
    required this.teacher,
  });
}

class FeePaymentRecord {
  final String title;
  final String amount;
  final String date;
  final String status;
  final String ref;

  const FeePaymentRecord({
    required this.title,
    required this.amount,
    required this.date,
    required this.status,
    required this.ref,
  });
}

class StudentFullProfile {
  final String id;
  final String grNo;
  final String rollNo;
  final String name;
  final String? avatarUrl;
  final String className;
  final String section;
  final String gender;
  final String dob;
  final String bloodGroup;
  final String house;
  final String admissionDate;
  final String classTeacher;
  final String category;

  // Parents
  final String fatherName;
  final String fatherOccupation;
  final String motherName;
  final String motherOccupation;
  final String parentPhone;
  final String parentEmail;
  final String emergencyPhone;
  final String residentialAddress;

  // Attendance
  final double attendancePct;
  final int totalDays;
  final int presentDays;
  final int leaveDays;
  final int absentDays;

  // Fees
  final String feeStatus; // 'PAID' or 'DUE'
  final double annualFee;
  final double feePaidAmount;
  final double feeDueAmount;
  final String nextDueDate;
  final List<FeePaymentRecord> feeHistory;

  // Academics
  final double overallPercentage;
  final String classRank;
  final List<SubjectMark> subjectMarks;
  final String principalRemarks;

  // Documents & Transport
  final String aadhaarNumber;
  final bool aadhaarVerified;
  final String busRoute;
  final String busStop;

  const StudentFullProfile({
    required this.id,
    required this.grNo,
    required this.rollNo,
    required this.name,
    this.avatarUrl,
    required this.className,
    required this.section,
    required this.gender,
    required this.dob,
    required this.bloodGroup,
    required this.house,
    required this.admissionDate,
    required this.classTeacher,
    required this.category,
    required this.fatherName,
    required this.fatherOccupation,
    required this.motherName,
    required this.motherOccupation,
    required this.parentPhone,
    required this.parentEmail,
    required this.emergencyPhone,
    required this.residentialAddress,
    required this.attendancePct,
    required this.totalDays,
    required this.presentDays,
    required this.leaveDays,
    required this.absentDays,
    required this.feeStatus,
    required this.annualFee,
    required this.feePaidAmount,
    required this.feeDueAmount,
    required this.nextDueDate,
    required this.feeHistory,
    required this.overallPercentage,
    required this.classRank,
    required this.subjectMarks,
    required this.principalRemarks,
    required this.aadhaarNumber,
    required this.aadhaarVerified,
    required this.busRoute,
    required this.busStop,
  });

  bool get isFeePaid => feeStatus.toUpperCase() == 'PAID';
}

class StudentsMockData {
  static List<StudentFullProfile> getStudents() {
    return [
      const StudentFullProfile(
        id: 'stu_01',
        grNo: 'GR-2024-101',
        rollNo: '101',
        name: 'Aarav Sharma',
        avatarUrl: 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=150&auto=format&fit=crop&q=80',
        className: 'Class 10',
        section: 'A',
        gender: 'Male',
        dob: '14 August 2010',
        bloodGroup: 'B+',
        house: 'Vanguard Blue House',
        admissionDate: '12 April 2022',
        classTeacher: 'Dr. Priya Verma',
        category: 'General',
        fatherName: 'Rajesh Sharma',
        fatherOccupation: 'Senior Software Architect',
        motherName: 'Sunita Sharma',
        motherOccupation: 'Assistant Professor',
        parentPhone: '+91 98111 22334',
        parentEmail: 'rajesh.sharma@gmail.com',
        emergencyPhone: '+91 98999 44321',
        residentialAddress: 'Flat 402, Royale Palm Heights, Sector 14, Mathura Road, New Delhi',
        attendancePct: 98.4,
        totalDays: 84,
        presentDays: 82,
        leaveDays: 2,
        absentDays: 0,
        feeStatus: 'PAID',
        annualFee: 54000,
        feePaidAmount: 54000,
        feeDueAmount: 0,
        nextDueDate: '15 Oct 2026 (Term 3)',
        feeHistory: [
          FeePaymentRecord(title: 'Term 1 Tuition & Annual Charges', amount: '₹ 27,000', date: '10 Apr 2026', status: 'PAID ONLINE', ref: 'TXN_8849102'),
          FeePaymentRecord(title: 'Term 2 Tuition & Science Lab Fee', amount: '₹ 27,000', date: '05 Aug 2026', status: 'PAID ONLINE', ref: 'TXN_9102834'),
        ],
        overallPercentage: 94.8,
        classRank: 'Rank 2 in Class 10-A',
        subjectMarks: [
          SubjectMark(subject: 'Advanced Mathematics', marks: 98, maxMarks: 100, grade: 'A+', teacher: 'Dr. Priya Verma'),
          SubjectMark(subject: 'Physics & Dynamics', marks: 94, maxMarks: 100, grade: 'A+', teacher: 'Prof. Alok Mukherjee'),
          SubjectMark(subject: 'Chemistry & Lab Practicals', marks: 92, maxMarks: 100, grade: 'A+', teacher: 'Prof. Alok Mukherjee'),
          SubjectMark(subject: 'Computer Science & AI', marks: 99, maxMarks: 100, grade: 'O (Outstanding)', teacher: 'Ms. Ananya Sengupta'),
          SubjectMark(subject: 'English Literature & Grammar', marks: 89, maxMarks: 100, grade: 'A', teacher: 'Mrs. Sunita Rao'),
        ],
        principalRemarks: 'Aarav is an exceptionally diligent scholar with sharp analytical thinking and excellent classroom participation.',
        aadhaarNumber: 'XXXX-XXXX-4921',
        aadhaarVerified: true,
        busRoute: 'Route 04 (Civil Lines Express)',
        busStop: 'Sector 14 Main Gate (DL 01 PB 4488)',
      ),
      const StudentFullProfile(
        id: 'stu_02',
        grNo: 'GR-2024-102',
        rollNo: '102',
        name: 'Ananya Iyer',
        avatarUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=150&auto=format&fit=crop&q=80',
        className: 'Class 10',
        section: 'A',
        gender: 'Female',
        dob: '05 November 2010',
        bloodGroup: 'O+',
        house: 'Phoenix Red House',
        admissionDate: '15 June 2021',
        classTeacher: 'Dr. Priya Verma',
        category: 'General',
        fatherName: 'Venkatesh Iyer',
        fatherOccupation: 'Chartered Accountant',
        motherName: 'Lakshmi Iyer',
        motherOccupation: 'School Principal (Primary)',
        parentPhone: '+91 98222 33445',
        parentEmail: 'venkat.iyer@fintech.in',
        emergencyPhone: '+91 98777 66554',
        residentialAddress: 'B-12, Greenview Enclave, Civil Lines, New Delhi',
        attendancePct: 99.1,
        totalDays: 84,
        presentDays: 83,
        leaveDays: 1,
        absentDays: 0,
        feeStatus: 'PAID',
        annualFee: 54000,
        feePaidAmount: 54000,
        feeDueAmount: 0,
        nextDueDate: '15 Oct 2026',
        feeHistory: [
          FeePaymentRecord(title: 'Term 1 Tuition Fee', amount: '₹ 27,000', date: '08 Apr 2026', status: 'PAID NETBANKING', ref: 'TXN_7749102'),
          FeePaymentRecord(title: 'Term 2 Tuition Fee', amount: '₹ 27,000', date: '02 Aug 2026', status: 'PAID UPI', ref: 'TXN_8819203'),
        ],
        overallPercentage: 97.2,
        classRank: 'Rank 1 in Class 10-A (Class Topper)',
        subjectMarks: [
          SubjectMark(subject: 'Advanced Mathematics', marks: 100, maxMarks: 100, grade: 'O (Centum)', teacher: 'Dr. Priya Verma'),
          SubjectMark(subject: 'Physics & Dynamics', marks: 97, maxMarks: 100, grade: 'A+', teacher: 'Prof. Alok Mukherjee'),
          SubjectMark(subject: 'Chemistry & Lab Practicals', marks: 96, maxMarks: 100, grade: 'A+', teacher: 'Prof. Alok Mukherjee'),
          SubjectMark(subject: 'Computer Science & AI', marks: 98, maxMarks: 100, grade: 'A+', teacher: 'Ms. Ananya Sengupta'),
          SubjectMark(subject: 'English Literature & Grammar', marks: 95, maxMarks: 100, grade: 'A+', teacher: 'Mrs. Sunita Rao'),
        ],
        principalRemarks: 'Exemplary academic topper with unmatched discipline. Recommended for National Olympiad representation.',
        aadhaarNumber: 'XXXX-XXXX-8834',
        aadhaarVerified: true,
        busRoute: 'Route 01 (North Campus)',
        busStop: 'Civil Lines Crossing (DL 01 PB 1102)',
      ),
      const StudentFullProfile(
        id: 'stu_03',
        grNo: 'GR-2024-103',
        rollNo: '103',
        name: 'Rohan Mehta',
        avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&auto=format&fit=crop&q=80',
        className: 'Class 10',
        section: 'B',
        gender: 'Male',
        dob: '22 March 2010',
        bloodGroup: 'A+',
        house: 'Titan Green House',
        admissionDate: '10 July 2023',
        classTeacher: 'Prof. Alok Mukherjee',
        category: 'OBC',
        fatherName: 'Sanjay Mehta',
        fatherOccupation: 'Automobile Retailer',
        motherName: 'Kavita Mehta',
        motherOccupation: 'Home Maker',
        parentPhone: '+91 98333 44556',
        parentEmail: 'sanjay.mehta@autoindia.com',
        emergencyPhone: '+91 98444 88776',
        residentialAddress: 'House 88, Dayanand Colony, Lajpat Nagar, New Delhi',
        attendancePct: 92.5,
        totalDays: 84,
        presentDays: 77,
        leaveDays: 5,
        absentDays: 2,
        feeStatus: 'DUE',
        annualFee: 54000,
        feePaidAmount: 49500,
        feeDueAmount: 4500,
        nextDueDate: 'Due Since 15 Aug',
        feeHistory: [
          FeePaymentRecord(title: 'Term 1 Tuition & Transport', amount: '₹ 32,000', date: '12 Apr 2026', status: 'PAID CASH', ref: 'RCP_44921'),
        ],
        overallPercentage: 86.4,
        classRank: 'Rank 12 in Class 10-B',
        subjectMarks: [
          SubjectMark(subject: 'Mathematics', marks: 84, maxMarks: 100, grade: 'A', teacher: 'Prof. Alok Mukherjee'),
          SubjectMark(subject: 'Physics', marks: 88, maxMarks: 100, grade: 'A', teacher: 'Dr. Priya Verma'),
        ],
        principalRemarks: 'Good potential; recommended additional practice in quantitative problem solving.',
        aadhaarNumber: 'XXXX-XXXX-9901',
        aadhaarVerified: true,
        busRoute: 'Route 04 (Civil Lines Express)',
        busStop: 'Lajpat Nagar Ring Road (DL 01 PB 4488)',
      ),
      const StudentFullProfile(
        id: 'stu_04',
        grNo: 'GR-2024-104',
        rollNo: '104',
        name: 'Diya Patel',
        avatarUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=150&auto=format&fit=crop&q=80',
        className: 'Class 9',
        section: 'A',
        gender: 'Female',
        dob: '18 September 2011',
        bloodGroup: 'B+',
        house: 'Vanguard Blue House',
        admissionDate: '01 April 2024',
        classTeacher: 'Ms. Sunita Roy',
        category: 'General',
        fatherName: 'Kirit Patel',
        fatherOccupation: 'Executive Director',
        motherName: 'Meena Patel',
        motherOccupation: 'Architect',
        parentPhone: '+91 98444 55667',
        parentEmail: 'kirit.patel@designstudio.in',
        emergencyPhone: '+91 98555 11223',
        residentialAddress: 'Tower B, DLF Phase 2, Gurugram',
        attendancePct: 96.0,
        totalDays: 84,
        presentDays: 80,
        leaveDays: 4,
        absentDays: 0,
        feeStatus: 'PAID',
        annualFee: 54000,
        feePaidAmount: 54000,
        feeDueAmount: 0,
        nextDueDate: '15 Oct 2026',
        feeHistory: [
          FeePaymentRecord(title: 'Term 1 & 2 Annual Fee', amount: '₹ 54,000', date: '02 Apr 2026', status: 'PAID ONLINE', ref: 'TXN_4481023'),
        ],
        overallPercentage: 91.5,
        classRank: 'Rank 5 in Class 9-A',
        subjectMarks: [
          SubjectMark(subject: 'English Core', marks: 95, maxMarks: 100, grade: 'A+', teacher: 'Ms. Sunita Roy'),
        ],
        principalRemarks: 'Creative thinker with outstanding communication skills and leadership.',
        aadhaarNumber: 'XXXX-XXXX-3341',
        aadhaarVerified: true,
        busRoute: 'Route 02 (South Corridor)',
        busStop: 'DLF Phase 2 Corner (DL 01 PB 1102)',
      ),
      const StudentFullProfile(
        id: 'stu_05',
        grNo: 'GR-2024-105',
        rollNo: '105',
        name: 'Kabir Kapoor',
        avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&auto=format&fit=crop&q=80',
        className: 'Class 11',
        section: 'Science',
        gender: 'Male',
        dob: '02 February 2009',
        bloodGroup: 'AB+',
        house: 'Phoenix Red House',
        admissionDate: '20 August 2020',
        classTeacher: 'Mr. Rajeshwar Rao',
        category: 'General',
        fatherName: 'Anil Kapoor',
        fatherOccupation: 'Business Owner',
        motherName: 'Neetu Kapoor',
        motherOccupation: 'Designer',
        parentPhone: '+91 98555 66778',
        parentEmail: 'anil.kapoor@textiles.com',
        emergencyPhone: '+91 98666 22334',
        residentialAddress: 'C-44, Greater Kailash 1, New Delhi',
        attendancePct: 94.2,
        totalDays: 84,
        presentDays: 79,
        leaveDays: 5,
        absentDays: 0,
        feeStatus: 'DUE',
        annualFee: 62000,
        feePaidAmount: 54800,
        feeDueAmount: 7200,
        nextDueDate: 'Due Since 10 Aug',
        feeHistory: [
          FeePaymentRecord(title: 'Term 1 Fee', amount: '₹ 31,000', date: '15 Apr 2026', status: 'PAID ONLINE', ref: 'TXN_112093'),
        ],
        overallPercentage: 89.0,
        classRank: 'Rank 8 in Class 11-Sci',
        subjectMarks: [
          SubjectMark(subject: 'Computer Science & AI', marks: 96, maxMarks: 100, grade: 'A+', teacher: 'Mr. Rajeshwar Rao'),
        ],
        principalRemarks: 'Strong coding acumen. Enthusiastic participation in robotics club.',
        aadhaarNumber: 'XXXX-XXXX-6612',
        aadhaarVerified: true,
        busRoute: 'Route 04 (Civil Lines Express)',
        busStop: 'GK-1 M-Block Market (DL 01 PB 4488)',
      ),
    ];
  }
}

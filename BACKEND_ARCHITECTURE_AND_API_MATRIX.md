# VortiQen Unified Backend Architecture & API Matrix Specification

> **Document Purpose**: Exhaustive reference specification capturing every API endpoint, WebSocket topic, Prisma database schema, authentication flow, and data contract across all 7 VortiQen applications (`student_app`, `teacher_app`, `parent_app`, `driver_app`, `director_app`, `admin_app`, `superadmin_app`). This document ensures zero ambiguity when implementing the NestJS / Prisma / PostgreSQL backend.

---

## 1. System Architecture Overview

```
                          ┌────────────────────────────────────────────────────────┐
                          │                 VortiQen Flutter Monorepo              │
                          │   Student • Teacher • Parent • Driver • Director •     │
                          │            School Admin • SuperAdmin                   │
                          └───────────────────────────┬────────────────────────────┘
                                                      │ (HTTPS REST / WSS Socket.io)
                                                      ▼
                          ┌────────────────────────────────────────────────────────┐
                          │                 NestJS API Gateway Layer               │
                          │  - Global JWT & Refresh Token Guard                    │
                          │  - Role-Based Access Control (RBAC) Guard              │
                          │  - Multi-Tenant Schema / SchoolId Context Interceptor  │
                          │  - Distributed Rate Limiter & Request Sanitizer        │
                          └───────────────────────────┬────────────────────────────┘
                                                      │
                  ┌───────────────────────────────────┼───────────────────────────────────┐
                  ▼                                   ▼                                   ▼
      ┌──────────────────────────────┐ ┌──────────────────────────────┐ ┌──────────────────────────────┐
      │ Core Service Micro-Modules   │ │ Redis Cluster                │ │ Cloud Object Storage (S3)    │
      │ - Auth & Multi-Tenancy Engine│ │ - Realtime Bus GPS Ping Cache│ │ - Student HW Submissions     │
      │ - Academics, HW & AI Quiz Hub│ │ - Socket.io Pub/Sub Adapter  │ │ - Official Signed Report PDFs│
      │ - Attendance & Leave Desk    │ │ - Session & Rate Limit Store │ │ - Fee Receipts & Tax Invoices│
      │ - GPS Fleet Radar & SOS Desk │ └──────────────────────────────┘ │ - Circular Notice PDFs       │
      │ - Fee Billing & UPI Gateways │                                  │ - Fuel Bill Receipt Scans    │
      │ - HR, Payroll & Biometrics   │                                  └──────────────────────────────┘
      │ - Executive Analytics HUD    │
      └──────────────┬───────────────┘
                     │ (Prisma ORM with Connection Pooling)
                     ▼
      ┌──────────────────────────────┐
      │ PostgreSQL 16 DB (Relational)│
      │ - School Tenant Isolation    │
      │ - Row Level Security (RLS)   │
      │ - Full Audit Trail History   │
      └──────────────────────────────┘
```

---

## 2. Multi-Tenant Database Schema (Prisma ORM Definitions)

```prisma
datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

generator client {
  provider = "prisma-client-js"
}

enum Role {
  SUPER_ADMIN
  DIRECTOR
  SCHOOL_ADMIN
  TEACHER
  STUDENT
  PARENT
  DRIVER
}

enum AttendanceStatus {
  PRESENT
  ABSENT
  LATE
  EXCUSED_LEAVE
  HOLIDAY
}

enum LeaveStatus {
  PENDING
  APPROVED
  REJECTED
}

enum AssignmentStatus {
  PENDING
  IN_PROGRESS
  SUBMITTED
  GRADED
  LATE
}

enum PaymentStatus {
  PENDING
  PROCESSING
  SUCCESS
  FAILED
  REFUNDED
}

enum TripStatus {
  SCHEDULED
  IN_PROGRESS
  COMPLETED
  CANCELLED
  SOS_TRIGGERED
}

enum ApprovalStatus {
  PENDING
  APPROVED
  REJECTED
  REVISION_REQUESTED
}

// -------------------------------------------------------------
// 1. TENANCY & USERS
// -------------------------------------------------------------
model School {
  id              String         @id @default(uuid())
  code            String         @unique // e.g. "DPS_NOIDA"
  name            String
  affiliationNo   String?
  address         String
  city            String
  state           String
  pincode         String
  contactEmail    String
  contactPhone    String
  logoUrl         String?
  licenseTier     String         @default("ENTERPRISE") // STANDARD | ENTERPRISE | AI_ARENA
  maxStudents     Int            @default(2000)
  isActive        Boolean        @default(true)
  createdAt       DateTime       @default(now())
  updatedAt       DateTime       @updatedAt

  users           User[]
  students        Student[]
  parents         ParentProfile[]
  teachers        TeacherProfile[]
  drivers         DriverProfile[]
  classes         Class[]
  routes          TransportRoute[]
  feeStructures   FeeStructure[]
  notices         SchoolNotice[]
  requisitions    RequisitionApproval[]
}

model User {
  id              String         @id @default(uuid())
  schoolId        String?
  school          School?        @relation(fields: [schoolId], references: [id], onDelete: Cascade)
  email           String?        @unique
  phone           String?        @unique
  username        String         @unique
  passwordHash    String
  role            Role
  fullName        String
  avatarUrl       String?
  isActive        Boolean        @default(true)
  createdAt       DateTime       @default(now())
  updatedAt       DateTime       @updatedAt

  studentProfile  Student?
  parentProfile   ParentProfile?
  teacherProfile  TeacherProfile?
  driverProfile   DriverProfile?
}

// -------------------------------------------------------------
// 2. ACADEMIC STRUCTURE & PROFILES
// -------------------------------------------------------------
model Class {
  id              String         @id @default(uuid())
  schoolId        String
  school          School         @relation(fields: [schoolId], references: [id], onDelete: Cascade)
  name            String         // e.g. "Class 10"
  section         String         // e.g. "A"
  academicYear    String         // e.g. "2026-2027"
  classTeacherId  String?
  classTeacher    TeacherProfile? @relation("ClassTeacherRelation", fields: [classTeacherId], references: [id])

  students        Student[]
  subjects        Subject[]
  assignments     Assignment[]
  attendance      DailyAttendance[]
}

model Subject {
  id              String         @id @default(uuid())
  classId         String
  class           Class          @relation(fields: [classId], references: [id], onDelete: Cascade)
  name            String         // e.g. "Physics", "Calculus"
  code            String         // e.g. "PHY-101"
  teacherId       String?
  teacher         TeacherProfile? @relation(fields: [teacherId], references: [id])
  assignments     Assignment[]
  curriculumUnits CurriculumUnit[]
}

model CurriculumUnit {
  id              String         @id @default(uuid())
  subjectId       String
  subject         Subject        @relation(fields: [subjectId], references: [id], onDelete: Cascade)
  unitNumber      Int
  title           String         // e.g. "Electromagnetic Induction"
  learningGoals   String[]
  youtubeLectures String[]       // Video URLs
  pyqPdfUrl       String?        // Past Year Question Paper PDF
  solutionsPdfUrl String?
}

model Student {
  id              String         @id @default(uuid())
  userId          String         @unique
  user            User           @relation(fields: [userId], references: [id], onDelete: Cascade)
  schoolId        String
  school          School         @relation(fields: [schoolId], references: [id], onDelete: Cascade)
  classId         String
  class           Class          @relation(fields: [classId], references: [id])
  rollNo          String
  admissionNo     String         @unique
  dateOfBirth     DateTime?
  gender          String?
  busRouteId      String?
  busRoute        TransportRoute? @relation(fields: [busRouteId], references: [id])
  busStopId       String?
  busStop         BusStop?       @relation(fields: [busStopId], references: [id])

  parents         ParentProfile[] @relation("ParentStudentLink")
  submissions     AssignmentSubmission[]
  attendanceLogs  StudentAttendanceRecord[]
  leaveRequests   StudentLeaveRequest[]
  feeLedgers      StudentFeeLedger[]
  reportCards     ReportCard[]
  calendarTasks   StudentStudyTask[]
}

model ParentProfile {
  id              String         @id @default(uuid())
  userId          String         @unique
  user            User           @relation(fields: [userId], references: [id], onDelete: Cascade)
  schoolId        String
  school          School         @relation(fields: [schoolId], references: [id], onDelete: Cascade)
  occupation      String?
  secondaryPhone  String?

  children        Student[]      @relation("ParentStudentLink")
  ptmBookings     PtmBooking[]
  leaveRequests   StudentLeaveRequest[]
}

model TeacherProfile {
  id              String         @id @default(uuid())
  userId          String         @unique
  user            User           @relation(fields: [userId], references: [id], onDelete: Cascade)
  schoolId        String
  school          School         @relation(fields: [schoolId], references: [id], onDelete: Cascade)
  designation     String         // e.g. "Senior PGT Physics"
  department      String         // e.g. "Science & STEM"
  employeeCode    String         @unique

  taughtClasses   Class[]        @relation("ClassTeacherRelation")
  taughtSubjects  Subject[]
  assignments     Assignment[]
  ptmSlots        PtmSlot[]
}

model DriverProfile {
  id              String         @id @default(uuid())
  userId          String         @unique
  user            User           @relation(fields: [userId], references: [id], onDelete: Cascade)
  schoolId        String
  school          School         @relation(fields: [schoolId], references: [id], onDelete: Cascade)
  licenseNo       String         @unique
  assignedBusNo   String         // e.g. "UP-16-BT-4092"
  vehicleModel    String         // e.g. "32-Seater Eicher Starline"
  emergencyPhone  String

  routes          TransportRoute[]
  trips           TransportTrip[]
  vehicleLogs     VehicleFuelLog[]
}

// -------------------------------------------------------------
// 3. HOMEWORK & ASSIGNMENTS
// -------------------------------------------------------------
model Assignment {
  id              String         @id @default(uuid())
  schoolId        String
  classId         String
  class           Class          @relation(fields: [classId], references: [id], onDelete: Cascade)
  subjectId       String
  subject         Subject        @relation(fields: [subjectId], references: [id], onDelete: Cascade)
  teacherId       String
  teacher         TeacherProfile @relation(fields: [teacherId], references: [id])
  title           String
  description     String
  assignedDate    DateTime       @default(now())
  dueDate         DateTime
  maxMarks        Int            @default(100)
  attachmentUrls  String[]
  createdAt       DateTime       @default(now())

  submissions     AssignmentSubmission[]
}

model AssignmentSubmission {
  id              String         @id @default(uuid())
  assignmentId    String
  assignment      Assignment     @relation(fields: [assignmentId], references: [id], onDelete: Cascade)
  studentId       String
  student         Student        @relation(fields: [studentId], references: [id], onDelete: Cascade)
  submittedAt     DateTime       @default(now())
  fileUrls        String[]
  studentNotes    String?
  status          AssignmentStatus @default(SUBMITTED)
  score           Float?
  teacherRemarks  String?
  gradedAt        DateTime?
  parentSigned    Boolean        @default(false)
  parentSignedAt  DateTime?
}

// -------------------------------------------------------------
// 4. ATTENDANCE & LEAVES
// -------------------------------------------------------------
model DailyAttendance {
  id              String         @id @default(uuid())
  classId         String
  class           Class          @relation(fields: [classId], references: [id], onDelete: Cascade)
  date            DateTime
  markedById      String
  records         StudentAttendanceRecord[]

  @@unique([classId, date])
}

model StudentAttendanceRecord {
  id              String           @id @default(uuid())
  dailyAttendanceId String
  dailyAttendance DailyAttendance  @relation(fields: [dailyAttendanceId], references: [id], onDelete: Cascade)
  studentId       String
  student         Student          @relation(fields: [studentId], references: [id], onDelete: Cascade)
  status          AttendanceStatus @default(PRESENT)
  remarks         String?
}

model StudentLeaveRequest {
  id              String         @id @default(uuid())
  studentId       String
  student         Student        @relation(fields: [studentId], references: [id], onDelete: Cascade)
  parentId        String
  parent          ParentProfile  @relation(fields: [parentId], references: [id])
  startDate       DateTime
  endDate         DateTime
  reasonCategory  String         // e.g. "Medical Sickness / Fever"
  notes           String
  documentUrl     String?
  status          LeaveStatus    @default(PENDING)
  reviewedById    String?
  reviewedAt      DateTime?
  reviewNotes     String?
  createdAt       DateTime       @default(now())
}

// -------------------------------------------------------------
// 5. TRANSPORT, GPS & SOS
// -------------------------------------------------------------
model TransportRoute {
  id              String         @id @default(uuid())
  schoolId        String
  school          School         @relation(fields: [schoolId], references: [id], onDelete: Cascade)
  name            String         // e.g. "Route 14 • North City Line"
  busNo           String         // e.g. "UP-16-BT-4092"
  driverId        String?
  driver          DriverProfile? @relation(fields: [driverId], references: [id])
  attendantName   String?
  attendantPhone  String?

  stops           BusStop[]
  students        Student[]
  trips           TransportTrip[]
}

model BusStop {
  id              String         @id @default(uuid())
  routeId         String
  route           TransportRoute @relation(fields: [routeId], references: [id], onDelete: Cascade)
  stopName        String
  stopOrder       Int
  scheduledTime   String         // e.g. "07:35 AM"
  latitude        Float
  longitude       Float
  students        Student[]
}

model TransportTrip {
  id              String         @id @default(uuid())
  routeId         String
  route           TransportRoute @relation(fields: [routeId], references: [id], onDelete: Cascade)
  driverId        String
  driver          DriverProfile  @relation(fields: [driverId], references: [id])
  shift           String         // MORNING | EVENING
  startOdometer   Float
  endOdometer     Float?
  status          TripStatus     @default(SCHEDULED)
  startedAt       DateTime?
  completedAt     DateTime?

  pings           LiveGpsPing[]
  boardings       StudentBoardingLog[]
  sosEvents       EmergencySosEvent[]
}

model LiveGpsPing {
  id              String         @id @default(uuid())
  tripId          String
  trip            TransportTrip  @relation(fields: [tripId], references: [id], onDelete: Cascade)
  latitude        Float
  longitude       Float
  speedKmh        Float
  headingDeg      Float
  recordedAt      DateTime       @default(now())
}

model StudentBoardingLog {
  id              String         @id @default(uuid())
  tripId          String
  trip            TransportTrip  @relation(fields: [tripId], references: [id], onDelete: Cascade)
  studentId       String
  stopId          String
  action          String         // BOARD | DEBOARD
  scannedAt       DateTime       @default(now())
}

model EmergencySosEvent {
  id              String         @id @default(uuid())
  tripId          String
  trip            TransportTrip  @relation(fields: [tripId], references: [id], onDelete: Cascade)
  category        String         // BREAKDOWN | MEDICAL | ACCIDENT | WEATHER
  latitude        Float
  longitude       Float
  triggeredAt     DateTime       @default(now())
  resolvedAt      DateTime?
  resolutionNotes String?
}

model VehicleFuelLog {
  id              String         @id @default(uuid())
  driverId        String
  driver          DriverProfile  @relation(fields: [driverId], references: [id])
  vehicleNo       String
  date            DateTime       @default(now())
  odometerKm      Float
  fuelLiters      Float
  totalCost       Float
  receiptImageUrl String?
  safetyAuditOk   Boolean        @default(true)
}

// -------------------------------------------------------------
// 6. FEES & FINANCIAL TRANSACTIONS
// -------------------------------------------------------------
model FeeStructure {
  id              String         @id @default(uuid())
  schoolId        String
  school          School         @relation(fields: [schoolId], references: [id], onDelete: Cascade)
  name            String         // e.g. "Quarter 3 Tuition & Transport 2026-27"
  academicYear    String
  dueDate         DateTime
  tuitionAmount   Float
  transportAmount Float          @default(0)
  labSurcharge    Float          @default(0)
  sportsAmount    Float          @default(0)

  ledgers         StudentFeeLedger[]
}

model StudentFeeLedger {
  id              String         @id @default(uuid())
  feeStructureId  String
  feeStructure    FeeStructure   @relation(fields: [feeStructureId], references: [id])
  studentId       String
  student         Student        @relation(fields: [studentId], references: [id], onDelete: Cascade)
  totalAmount     Float
  paidAmount      Float          @default(0)
  pendingAmount   Float
  status          PaymentStatus  @default(PENDING)
  receiptPdfUrl   String?

  payments        PaymentTransaction[]
}

model PaymentTransaction {
  id              String         @id @default(uuid())
  ledgerId        String
  ledger          StudentFeeLedger @relation(fields: [ledgerId], references: [id], onDelete: Cascade)
  orderId         String         @unique // Razorpay / Stripe Order ID
  paymentId       String?        // Gateway transaction hash
  amount          Float
  method          String         // UPI | NET_BANKING | CARDS
  status          PaymentStatus  @default(PENDING)
  paidAt          DateTime?
  receiptNo       String         @unique // e.g. "REC-2026-0892"
}

// -------------------------------------------------------------
// 7. PTM CONSULTATIONS, EXAMS & NOTICES
// -------------------------------------------------------------
model PtmSlot {
  id              String         @id @default(uuid())
  teacherId       String
  teacher         TeacherProfile @relation(fields: [teacherId], references: [id], onDelete: Cascade)
  date            DateTime
  timeSlot        String         // e.g. "10:15 AM - 10:30 AM"
  mode            String         // IN_PERSON | VIRTUAL
  roomOrMeetUrl   String
  isBooked        Boolean        @default(false)

  booking         PtmBooking?
}

model PtmBooking {
  id              String         @id @default(uuid())
  ptmSlotId       String         @unique
  ptmSlot         PtmSlot        @relation(fields: [ptmSlotId], references: [id], onDelete: Cascade)
  parentId        String
  parent          ParentProfile  @relation(fields: [parentId], references: [id], onDelete: Cascade)
  discussionAgenda String
  bookedAt        DateTime       @default(now())
}

model ReportCard {
  id              String         @id @default(uuid())
  studentId       String
  student         Student        @relation(fields: [studentId], references: [id], onDelete: Cascade)
  term            String         // "Term 1 (Session 2026-27)"
  gpaScore        Float          // e.g. 9.32
  overallGrade    String         // "A1 Distinction"
  classRank       Int            // 3
  totalInClass    Int            // 42
  subjectScores   Json           // Array of { subject, marks, maxMarks, grade, classAvg, teacher }
  teacherRemarks  String
  principalRemarks String
  signedPdfUrl    String
  publishedAt     DateTime       @default(now())
}

model SchoolNotice {
  id              String         @id @default(uuid())
  schoolId        String
  school          School         @relation(fields: [schoolId], references: [id], onDelete: Cascade)
  category        String         // ACADEMICS | TRANSPORT | HOLIDAYS | SPORTS_EVENTS
  title           String
  summary         String
  author          String
  isUrgent        Boolean        @default(false)
  attachmentUrl   String?
  targetRoles     Role[]         // [STUDENT, PARENT, TEACHER]
  createdAt       DateTime       @default(now())
}

model StudentStudyTask {
  id              String         @id @default(uuid())
  studentId       String
  student         Student        @relation(fields: [studentId], references: [id], onDelete: Cascade)
  date            DateTime
  title           String
  subject         String
  category        String         // STUDY | HOMEWORK | REVISION
  priority        String         // HIGH | MEDIUM | LOW
  isCompleted     Boolean        @default(false)
}

model RequisitionApproval {
  id              String         @id @default(uuid())
  schoolId        String
  school          School         @relation(fields: [schoolId], references: [id], onDelete: Cascade)
  reqNumber       String         @unique // e.g. "REQ-2026-881"
  title           String
  department      String
  requestedBy     String
  amount          Float
  justification   String
  category        String         // CAPEX_PURCHASE | EVENT_BUDGET | ACADEMIC_RESOURCE
  status          ApprovalStatus @default(PENDING)
  approvedById    String?
  approvedAt      DateTime?
  createdAt       DateTime       @default(now())
}
```

---

## 3. Page-to-API Matrix by Application

### 🎓 1. Student App (`apps/student_app`)

| Screen / Feature | User Action | HTTP Method & Endpoint | WebSocket Topic | Request / Response Payload |
| :--- | :--- | :--- | :--- | :--- |
| **Login** | Enter Roll No/Username & Password | `POST /api/v1/auth/student-login` | - | `Req: { username, password, schoolCode }`<br>`Res: { token, studentProfile }` |
| **Dashboard** | View summary KPIs & notices | `GET /api/v1/student/dashboard-summary` | `notices:school` | `Res: { attendancePct, nextClass, feeDue, notices: [] }` |
| **Smart Calendar & Mood** | Log mood / Set study task / Reminder | `POST /api/v1/student/calendar/tasks`<br>`POST /api/v1/student/calendar/mood` | - | `Req: { date, title, subject, priority, category }` |
| **Academics & Homework** | View homework & submit solution | `GET /api/v1/assignments/student`<br>`POST /api/v1/assignments/:id/submit` | `assignment:graded` | `Req: FormData { file, notes }`<br>`Res: { submissionId, status: "SUBMITTED" }` |
| **AI Quiz Challenge** | Attempt interactive quiz | `POST /api/v1/quiz/generate`<br>`POST /api/v1/quiz/submit` | - | `Req: { subject, topic, difficulty, answers: [] }`<br>`Res: { score, xpGained, rank }` |
| **YouTube Lectures** | View curated video playlist | `GET /api/v1/academics/youtube-lectures` | - | `Res: [ { title, videoUrl, teacherName, unit } ]` |
| **Unit-wise PYQs** | Download board past papers | `GET /api/v1/academics/pyqs` | - | `Res: [ { year, subject, unit, pdfUrl, solutionsUrl } ]` |
| **Live Bus Tracking** | Track school bus on map | `GET /api/v1/transport/my-bus/route` | `bus:location:<vehicleId>` | `WS Stream: { lat, lng, speed, heading, nextStop, eta }` |
| **Attendance** | View monthly attendance log | `GET /api/v1/attendance/student-log` | - | `Res: { presentDays, absentDays, monthlyLog: [] }` |
| **Fees** | View fee invoice & payment history | `GET /api/v1/fees/student-dues` | - | `Res: { totalDue, dueDate, invoiceBreakdown: [] }` |
| **Exams & Results** | View datesheet & report cards | `GET /api/v1/exams/my-results` | - | `Res: { termGpa, marks: [], rank, pdfUrl }` |

---

### 👨‍🏫 2. Teacher App (`apps/teacher_app`)

| Screen / Feature | User Action | HTTP Method & Endpoint | WebSocket Topic | Request / Response Payload |
| :--- | :--- | :--- | :--- | :--- |
| **Dashboard & Schedule** | View today's periods & agenda | `GET /api/v1/teacher/today-schedule` | - | `Res: { periods: [], ptmSlots: [], facultySync: [] }` |
| **Roll Call / Attendance** | Mark class attendance | `POST /api/v1/attendance/mark-batch` | `attendance:marked` | `Req: { classId, sectionId, date, records: [{ studentId, status: 'P'|'A'|'L' }] }` |
| **Assignment Creator** | Publish new assignment with files | `POST /api/v1/assignments/create` | `assignment:new` | `Req: FormData { title, classId, subjectId, dueDate, maxMarks, attachment }` |
| **Assignment Grading** | Grade submitted homework | `PATCH /api/v1/assignments/submissions/:id/grade` | `assignment:graded` | `Req: { marksAwarded, teacherFeedback }` |
| **Daily Lesson Planner** | Save lesson plan & teaching notes | `POST /api/v1/academics/lesson-plans` | - | `Req: { classId, subject, chapter, learningObjectives, resources }` |
| **PTM Slot Manager** | Open parent meeting consultation slots| `POST /api/v1/meetings/ptm-slots` | `ptm:booked` | `Req: { date, timeSlot, roomOrLink, maxParents }` |
| **Leave Approval Desk** | Review student leave requests | `PATCH /api/v1/attendance/leave-requests/:id` | - | `Req: { status: 'APPROVED' | 'REJECTED', notes }` |

---

### 👪 3. Parent App (`apps/parent_app`)

| Screen / Feature | User Action | HTTP Method & Endpoint | WebSocket Topic | Request / Response Payload |
| :--- | :--- | :--- | :--- | :--- |
| **Child Switcher** | Switch between enrolled children | `POST /api/v1/parent/switch-child` | - | `Req: { childId }` -> `Res: { childProfile, currentToken }` |
| **Live Bus Radar** | Live GPS map with speed & ETA | `GET /api/v1/transport/child-bus/:childId` | `bus:location:<vehicleId>` | `WS Stream: { lat, lng, speed, driverPhone, stopETA }` |
| **Boarding Alerts** | Receive pickup/drop notifications | - | `transport:student:boarded` | `WS Push: { studentName, stopName, time, status: 'BOARDED' }` |
| **Fee Payment** | Pay pending fee via UPI/Cards | `POST /api/v1/fees/create-order`<br>`POST /api/v1/fees/verify-payment` | `fee:payment:success` | `Req: { studentId, feeLedgerIds: [], amount, gateway: 'RAZORPAY' }`<br>`Res: { orderId, receiptPdfUrl }` |
| **Homework Tracker** | View child's pending assignments | `GET /api/v1/parent/child-assignments/:childId`| - | `Res: [ { title, subject, dueDate, isSubmitted, marks } ]` |
| **Apply Student Leave** | Submit leave application | `POST /api/v1/attendance/apply-leave` | - | `Req: FormData { childId, startDate, endDate, reason, attachment }` |
| **PTM Slot Booking** | Book consultation with teacher | `POST /api/v1/meetings/book-ptm-slot` | `ptm:booked` | `Req: { slotId, teacherId, discussionAgenda }` |
| **Report Card View** | Download term report card | `GET /api/v1/exams/child-report-card/:childId`| - | `Res: { term, overallGrade, subjectWise: [], pdfDownloadUrl }` |
| **School Notices** | Browse school circulars | `GET /api/v1/notices/school` | `notices:broadcast` | `Res: [ { category, title, summary, author, attachmentUrl } ]` |

---

### 🚌 4. Driver App (`apps/driver_app`)

| Screen / Feature | User Action | HTTP Method & Endpoint | WebSocket Topic | Request / Response Payload |
| :--- | :--- | :--- | :--- | :--- |
| **Trip Start / End** | Start morning/evening route trip | `POST /api/v1/driver/trip/toggle` | `transport:trip:state` | `Req: { routeId, vehicleId, tripType: 'PICKUP'|'DROP', action: 'START'|'STOP' }` |
| **Live GPS Broadcast** | Continuous background GPS stream | - | `driver:gps:publish` | `Payload: { vehicleId, routeId, lat, lng, speed, heading, timestamp }` |
| **Student Boarding Scanner**| QR/NFC scan at bus stop | `POST /api/v1/driver/trip/scan-student` | `transport:student:boarded` | `Req: { tripId, studentId, stopId, action: 'BOARD'|'DEBOARD' }` |
| **Emergency SOS Alert** | Press Panic SOS button | `POST /api/v1/driver/sos/trigger` | `transport:sos:broadcast` | `Req: { vehicleId, lat, lng, reason: 'ACCIDENT'|'BREAKDOWN'|'MEDICAL' }` |
| **Vehicle Log & Fuel** | Upload fuel bill & odometer reading | `POST /api/v1/driver/vehicle-logs` | - | `Req: FormData { vehicleId, odometerKm, fuelLiters, amount, receiptImage }` |
| **Driver Attendance** | Punch daily shift attendance | `POST /api/v1/driver/attendance/punch` | - | `Req: { lat, lng, shift: 'MORNING'|'EVENING' }` |

---

### 👔 5. Director App (`apps/director_app`)

| Screen / Feature | User Action | HTTP Method & Endpoint | WebSocket Topic | Request / Response Payload |
| :--- | :--- | :--- | :--- | :--- |
| **Executive Command HUD** | Realtime institutional KPIs | `GET /api/v1/director/executive-summary` | `director:kpi:refresh` | `Res: { totalStudents, totalStaff, feeCollectionPct, attendancePct }` |
| **Financial Cash Flow HUD**| Revenue vs Expense burn rate | `GET /api/v1/director/financial-analytics` | - | `Res: { mtdRevenue, ytdRevenue, pendingDues, monthlyExpenses, projections }` |
| **Academic Benchmarks** | Class-wise GPA & syllabus completion | `GET /api/v1/director/academic-benchmarks`| - | `Res: [ { class, averageGpa, passPct, topSubject, laggingSubject } ]` |
| **Teacher Performance** | Teacher ratings & punctuality index | `GET /api/v1/director/teacher-performance` | - | `Res: [ { teacherName, department, attendancePct, studentFeedbackScore } ]` |
| **Admission Funnel** | Track conversion of enquiries | `GET /api/v1/director/admissions-funnel` | - | `Res: { enquiriesCount, shortlistedCount, enrolledCount, revenueProjected }` |
| **Governance Approvals** | 1-Tap approval for requisitions & leaves| `PATCH /api/v1/director/approvals/:id` | - | `Req: { approvalType: 'EXPENSE'|'STAFF_LEAVE', decision: 'APPROVED'|'REJECTED' }` |

---

### 🏢 6. Admin App (`apps/admin_app`)

| Screen / Feature | User Action | HTTP Method & Endpoint | WebSocket Topic | Request / Response Payload |
| :--- | :--- | :--- | :--- | :--- |
| **Student Management** | Create / Edit student records | `POST /api/v1/students`, `GET /api/v1/students` | - | Full student CRUD with parent linkage, roll number, class assignment |
| **Fee Structure Engine**| Configure fee slabs & discount rules | `POST /api/v1/fees/structures`, `POST /api/v1/fees/generate-invoices` | - | Slabs: Tuition, Transport, Laboratory, Annual Sports |
| **Staff HR & Payroll** | Generate salary slips & track biometric | `POST /api/v1/hr/payroll/generate`, `GET /api/v1/hr/biometric-logs` | - | Leaves balance, PF, deductions, net salary disbursement |
| **Fleet Command Center**| Live map with all school buses | `GET /api/v1/transport/fleet/live` | `transport:fleet:stream` | Real-time map with geofencing breach alerts & SOS alerts |
| **Inventory & Assets** | Log school assets & purchase orders | `POST /api/v1/inventory/assets`, `POST /api/v1/inventory/purchase-orders` | - | Barcode tracking for lab equipment, computers, furniture |
| **School Circulars** | Broadcast notices to role groups | `POST /api/v1/notices/broadcast` | `notices:broadcast` | Target filters: `ALL`, `PARENTS_ONLY`, `TEACHERS_ONLY`, `CLASS_10` |

---

### 🌐 7. Superadmin App (`apps/superadmin_app`)

| Screen / Feature | User Action | HTTP Method & Endpoint | WebSocket Topic | Request / Response Payload |
| :--- | :--- | :--- | :--- | :--- |
| **School Onboarding** | Provision new school tenant | `POST /api/v1/superadmin/schools/provision` | - | Creates DB tenant space, admin account, domain alias, license quota |
| **SaaS Subscriptions** | Manage billing plans & module licenses | `PATCH /api/v1/superadmin/schools/:id/plan` | - | Tiers: Standard, Enterprise, AI Arena Tier |
| **Platform Telemetry** | Server health, API latency & DB load | `GET /api/v1/superadmin/system-health` | `telemetry:metrics` | CPU, Memory, Active WebSocket connections, Error rate |

---

## 4. Realtime WebSocket Channel Hierarchy

```
vortiqen/
  ├── tenant:<schoolId>/
  │     ├── notices/broadcast                (All connected users in school)
  │     ├── emergency/sos                    (Admin, Director & fleet managers)
  │     ├── ptm/updates                      (Teachers & Parents)
  │     └── chat/group:<groupId>             (Class discussion & faculty rooms)
  │
  └── transport/
        ├── bus:<vehicleId>/location         (Subscribed students & parents)
        ├── bus:<vehicleId>/stop-arrival     (Proximity push notification)
        └── student:<studentId>/boarding     (Parent instant boarding log)
```

---

## 5. Summary
With this complete backend contract in place, any UI page created across all 7 apps maps directly to known payloads, endpoints, and event structures. All frontend applications are synchronized and ready for the backend implementation phase!

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/academic_class.dart';
import '../models/subject.dart';
import '../models/user.dart';

class AcademicsRepository {
  AcademicsRepository();

  Future<List<AcademicClass>> getClasses() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return [
      AcademicClass(
        id: 'cls_10',
        schoolId: 'sch_01',
        name: 'Class 10',
        monthlyFee: 4500,
        sections: [
          AcademicSection(id: 'sec_10a', classId: 'cls_10', name: 'Section A'),
          AcademicSection(id: 'sec_10b', classId: 'cls_10', name: 'Section B'),
          AcademicSection(id: 'sec_10c', classId: 'cls_10', name: 'Section C'),
        ],
      ),
      AcademicClass(
        id: 'cls_09',
        schoolId: 'sch_01',
        name: 'Class 9',
        monthlyFee: 4200,
        sections: [
          AcademicSection(id: 'sec_09a', classId: 'cls_09', name: 'Section A'),
          AcademicSection(id: 'sec_09b', classId: 'cls_09', name: 'Section B'),
        ],
      ),
      AcademicClass(
        id: 'cls_11',
        schoolId: 'sch_01',
        name: 'Class 11 (Science & Commerce)',
        monthlyFee: 5200,
        sections: [
          AcademicSection(id: 'sec_11s', classId: 'cls_11', name: 'Section 11-PCM'),
          AcademicSection(id: 'sec_11c', classId: 'cls_11', name: 'Section 11-Commerce'),
        ],
      ),
      AcademicClass(
        id: 'cls_12',
        schoolId: 'sch_01',
        name: 'Class 12 (Board Senior)',
        monthlyFee: 5500,
        sections: [
          AcademicSection(id: 'sec_12s', classId: 'cls_12', name: 'Section 12-PCB'),
          AcademicSection(id: 'sec_12c', classId: 'cls_12', name: 'Section 12-Commerce'),
        ],
      ),
    ];
  }

  Future<AcademicClass> createClass(String name, List<String> sectionNames, {double monthlyFee = 0.0}) async {
    return AcademicClass(
      id: 'cls_new',
      schoolId: 'sch_01',
      name: name,
      monthlyFee: monthlyFee,
      sections: sectionNames.map((s) => AcademicSection(id: 'sec_$s', classId: 'cls_new', name: s)).toList(),
    );
  }

  Future<List<Subject>> getSubjects(String schoolId, {String? classId}) async {
    await Future.delayed(const Duration(milliseconds: 50));
    return [
      Subject(
        id: 'sub_01',
        name: 'Advanced Mathematics',
        classId: classId ?? 'cls_10',
        schoolId: schoolId,
        teacher: User(id: 'u_t1', name: 'Dr. Priya Verma', role: 'TEACHER', status: 'ACTIVE'),
      ),
      Subject(
        id: 'sub_02',
        name: 'Physics & Experimental Dynamics',
        classId: classId ?? 'cls_10',
        schoolId: schoolId,
        teacher: User(id: 'u_t2', name: 'Prof. Alok Mukherjee', role: 'TEACHER', status: 'ACTIVE'),
      ),
      Subject(
        id: 'sub_03',
        name: 'Chemistry & Molecular Lab',
        classId: classId ?? 'cls_10',
        schoolId: schoolId,
        teacher: User(id: 'u_t3', name: 'Dr. Sunita Rao', role: 'TEACHER', status: 'ACTIVE'),
      ),
      Subject(
        id: 'sub_04',
        name: 'Computer Science & Python',
        classId: classId ?? 'cls_10',
        schoolId: schoolId,
        teacher: User(id: 'u_t4', name: 'Er. Vikrant Mehta', role: 'TEACHER', status: 'ACTIVE'),
      ),
      Subject(
        id: 'sub_05',
        name: 'English Literature & Grammar',
        classId: classId ?? 'cls_10',
        schoolId: schoolId,
        teacher: User(id: 'u_t5', name: 'Mrs. Emily Davis', role: 'TEACHER', status: 'ACTIVE'),
      ),
    ];
  }

  Future<Subject> createSubject(Map<String, dynamic> subjectData) async {
    return Subject(
      id: 'sub_new',
      name: subjectData['name'] ?? 'New Subject',
      classId: subjectData['classId'] ?? 'cls_10',
      schoolId: 'sch_01',
    );
  }
}

final academicsRepositoryProvider = Provider<AcademicsRepository>((ref) {
  return AcademicsRepository();
});

final classesProvider = FutureProvider.autoDispose<List<AcademicClass>>((ref) {
  return ref.watch(academicsRepositoryProvider).getClasses();
});

final subjectsProvider = FutureProvider.family<List<Subject>, String>((ref, schoolId) {
  return ref.watch(academicsRepositoryProvider).getSubjects(schoolId);
});

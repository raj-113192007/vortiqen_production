class AcademicSection {
  final String id;
  final String classId;
  final String name;

  AcademicSection({
    required this.id,
    required this.classId,
    required this.name,
  });

  factory AcademicSection.fromJson(Map<String, dynamic> json) {
    return AcademicSection(
      id: json['id'] as String,
      classId: json['classId'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'classId': classId,
      'name': name,
    };
  }
}

class AcademicClass {
  final String id;
  final String schoolId;
  final String name;
  final double monthlyFee;
  final List<AcademicSection> sections;

  AcademicClass({
    required this.id,
    required this.schoolId,
    required this.name,
    this.monthlyFee = 0.0,
    this.sections = const [],
  });

  factory AcademicClass.fromJson(Map<String, dynamic> json) {
    return AcademicClass(
      id: json['id'] as String,
      schoolId: json['schoolId'] as String,
      name: json['name'] as String,
      monthlyFee: (json['monthlyFee'] as num?)?.toDouble() ?? 0.0,
      sections: (json['sections'] as List<dynamic>?)
              ?.map((e) => AcademicSection.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'schoolId': schoolId,
      'name': name,
      'monthlyFee': monthlyFee,
      'sections': sections.map((e) => e.toJson()).toList(),
    };
  }
}

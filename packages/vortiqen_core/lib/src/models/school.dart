class School {
  final String id;
  final String name;
  final String code;
  final String? address;
  final String? city;
  final String? state;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  School({
    required this.id,
    required this.name,
    required this.code,
    this.address,
    this.city,
    this.state,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

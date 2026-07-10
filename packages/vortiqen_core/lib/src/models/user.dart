class User {
  final String id;
  final String? username;
  final String? email;
  final String name;
  final String role;
  final String status;
  final String? schoolId;
  final String? phone;

  User({
    required this.id,
    this.username,
    this.email,
    required this.name,
    required this.role,
    required this.status,
    this.schoolId,
    this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      name: json['name'],
      role: json['role'],
      status: json['status'],
      schoolId: json['schoolId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'name': name,
      'role': role,
      'status': status,
      'schoolId': schoolId,
    };
  }
}

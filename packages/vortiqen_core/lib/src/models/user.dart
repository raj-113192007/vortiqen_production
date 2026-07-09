class User {
  final String id;
  final String? username;
  final String? email;
  final String name;
  final String role;
  final String status;
  final String? schoolId;

  User({
    required this.id,
    this.username,
    this.email,
    required this.name,
    required this.role,
    required this.status,
    this.schoolId,
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
}

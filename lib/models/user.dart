import 'package:cloud_firestore/cloud_firestore.dart';

enum UserRole { admin, employee }

class User {
  final String id;
  final String name;
  final UserRole role;
  final bool isAdmin;
  final String? email;
  final String? phone;
  final double? salary;
  final DateTime? joiningDate;
  final DateTime? createdAt;

  const User({
    required this.id,
    required this.name,
    required this.role,
    required this.isAdmin,
    this.email,
    this.phone,
    this.salary,
    this.joiningDate,
    this.createdAt,
  });

  bool get isStaff => role == UserRole.employee;
  bool get isEmployee => role == UserRole.employee;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'role': role.toString().split('.').last,
    'isAdmin': isAdmin,
    'email': email,
    'phone': phone,
    'salary': salary,
    'joiningDate': joiningDate,
    'createdAt': createdAt,
  };

  factory User.fromJson(Map<String, dynamic> json) {
    final roleString = (json['role'] as String?)?.toLowerCase() ?? 'employee';
    final role = roleString == 'admin' ? UserRole.admin : UserRole.employee;
    final bool isAdmin = json['isAdmin'] as bool? ?? (role == UserRole.admin);

    DateTime? joiningDate;
    if (json['joiningDate'] != null) {
      if (json['joiningDate'] is Timestamp) {
        joiningDate = (json['joiningDate'] as Timestamp).toDate();
      } else {
        joiningDate = DateTime.tryParse(json['joiningDate'] as String);
      }
    }

    DateTime? createdAt;
    if (json['createdAt'] != null) {
      if (json['createdAt'] is Timestamp) {
        createdAt = (json['createdAt'] as Timestamp).toDate();
      } else {
        createdAt = DateTime.tryParse(json['createdAt'] as String);
      }
    }

    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      role: role,
      isAdmin: isAdmin,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      salary: (json['salary'] as num?)?.toDouble(),
      joiningDate: joiningDate,
      createdAt: createdAt,
    );
  }
}


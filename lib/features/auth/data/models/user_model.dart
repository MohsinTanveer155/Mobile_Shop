import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/user_entity.dart';

/// Auth DTO — JSON / Firestore only. Maps to [UserEntity].
class UserModel {
  final String id;
  final String name;
  final String role;
  final bool isAdmin;
  final String? email;
  final String? phone;
  final double? salary;
  final DateTime? joiningDate;
  final DateTime? createdAt;

  const UserModel({
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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: (json['name'] as String?)?.trim().isNotEmpty == true
          ? (json['name'] as String).trim()
          : 'User',
      role: ((json['role'] as String?) ?? 'employee').toLowerCase(),
      isAdmin: json['isAdmin'] as bool? ??
          ((json['role'] as String?)?.toLowerCase() == 'admin'),
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      salary: (json['salary'] as num?)?.toDouble(),
      joiningDate: _parseDate(json['joiningDate']),
      createdAt: _parseDate(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'role': role,
        'isAdmin': isAdmin,
        'email': email,
        'phone': phone,
        'salary': salary,
        'joiningDate': joiningDate?.toIso8601String(),
        'createdAt': createdAt?.toIso8601String(),
      };

  /// Firestore write payload (no id field; id is the document key).
  Map<String, dynamic> toFirestore({bool includeServerTimestamps = false}) {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'isAdmin': isAdmin,
      'salary': salary,
      if (includeServerTimestamps) ...{
        'createdAt': FieldValue.serverTimestamp(),
        'joiningDate': FieldValue.serverTimestamp(),
      } else ...{
        if (joiningDate != null) 'joiningDate': Timestamp.fromDate(joiningDate!),
        if (createdAt != null) 'createdAt': Timestamp.fromDate(createdAt!),
      },
    };
  }

  UserEntity toEntity() {
    final normalizedRole =
        role == 'admin' ? UserRoleEntity.admin : UserRoleEntity.employee;
    return UserEntity(
      id: id,
      name: name,
      role: normalizedRole,
      isAdmin: isAdmin || normalizedRole == UserRoleEntity.admin,
      email: email,
      phone: phone,
      salary: salary,
      joiningDate: joiningDate,
      createdAt: createdAt,
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      role: entity.role == UserRoleEntity.admin ? 'admin' : 'employee',
      isAdmin: entity.isAdmin,
      email: entity.email,
      phone: entity.phone,
      salary: entity.salary,
      joiningDate: entity.joiningDate,
      createdAt: entity.createdAt,
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
}

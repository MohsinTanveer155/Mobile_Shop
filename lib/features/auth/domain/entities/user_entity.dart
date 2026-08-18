import 'package:equatable/equatable.dart';

enum UserRoleEntity { admin, employee }

/// Pure domain user. No Flutter / Firebase types.
class UserEntity extends Equatable {
  final String id;
  final String name;
  final UserRoleEntity role;
  final bool isAdmin;
  final String? email;
  final String? phone;
  final double? salary;
  final DateTime? joiningDate;
  final DateTime? createdAt;

  const UserEntity({
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

  bool get isStaff => role == UserRoleEntity.employee;
  bool get isEmployee => role == UserRoleEntity.employee;

  UserEntity copyWith({
    String? id,
    String? name,
    UserRoleEntity? role,
    bool? isAdmin,
    String? email,
    String? phone,
    double? salary,
    DateTime? joiningDate,
    DateTime? createdAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      isAdmin: isAdmin ?? this.isAdmin,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      salary: salary ?? this.salary,
      joiningDate: joiningDate ?? this.joiningDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        role,
        isAdmin,
        email,
        phone,
        salary,
        joiningDate,
        createdAt,
      ];
}

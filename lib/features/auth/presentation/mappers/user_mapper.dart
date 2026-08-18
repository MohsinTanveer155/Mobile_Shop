import '../../../../models/user.dart' as app;
import '../../domain/entities/user_entity.dart';

/// Maps domain entities to the app-wide [User] model used by existing screens.
extension UserEntityMapper on UserEntity {
  app.User toAppUser() {
    return app.User(
      id: id,
      name: name,
      role: role == UserRoleEntity.admin ? app.UserRole.admin : app.UserRole.employee,
      isAdmin: isAdmin,
      email: email,
      phone: phone,
      salary: salary,
      joiningDate: joiningDate,
      createdAt: createdAt,
    );
  }
}

extension AppUserMapper on app.User {
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      role: role == app.UserRole.admin ? UserRoleEntity.admin : UserRoleEntity.employee,
      isAdmin: isAdmin,
      email: email,
      phone: phone,
      salary: salary,
      joiningDate: joiningDate,
      createdAt: createdAt,
    );
  }
}

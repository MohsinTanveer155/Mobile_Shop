import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_shop/models/user.dart';
import 'package:mobile_shop/services/auth_service.dart';

void main() {
  group('AuthService fallback profile', () {
    test('creates a fallback user profile from auth data', () {
      final user = AuthService.createFallbackUser(
        uid: 'abc123',
        email: 'staff@example.com',
        displayName: 'Staff User',
      );

      expect(user.id, 'abc123');
      expect(user.email, 'staff@example.com');
      expect(user.name, 'Staff User');
      expect(user.isAdmin, false);
      expect(user.role, UserRole.employee);
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import 'staff/staff_profile_screen.dart';
import '../widgets/admin_shell.dart';
import 'login_screen.dart';

/// Routes to the role-appropriate profile experience.
class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    if (user == null) {
      return const LoginScreen();
    }
    if (user.isAdmin) {
      return const AdminShell(initialIndex: 4);
    }
    return const StaffProfileScreen();
  }
}

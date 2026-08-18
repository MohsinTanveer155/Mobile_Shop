import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/colors.dart';
import '../../providers/app_providers.dart';
import 'widgets/staff_dashboard_widgets.dart';

class StaffDashboardScreen extends ConsumerWidget {
  final bool embedded;

  const StaffDashboardScreen({super.key, this.embedded = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    if (user == null) {
      return _buildUnauthorizedScaffold();
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: !embedded,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StaffHeaderWidget(user: user),
            const SizedBox(height: 20),
            TodayAttendanceCard(uid: user.id),
            const SizedBox(height: 24),
            const QuickActionsWidget(),
          ],
        ),
      ),
    );
  }

  Scaffold _buildUnauthorizedScaffold() {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: !embedded,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Please sign in to view the staff dashboard.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ),
      ),
    );
  }
}

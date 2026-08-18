import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../config/colors.dart';
import '../../../models/attendance_record.dart';
import '../../../models/user.dart';
import '../../../providers/app_providers.dart';
import '../attendance_screen.dart';
import '../leave_screen.dart';
import '../salary_screen.dart';
import '../staff_profile_screen.dart';

String staffGreeting(DateTime now) {
  final hour = now.hour;
  if (hour < 12) return 'Good Morning';
  if (hour < 17) return 'Good Afternoon';
  return 'Good Evening';
}

// ==================== GREETING HEADER ====================
class StaffHeaderWidget extends StatelessWidget {
  final User user;

  const StaffHeaderWidget({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final greeting = staffGreeting(DateTime.now());
    final firstName = user.name.trim().split(RegExp(r'\s+')).first;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$greeting, $firstName 👋',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          user.isAdmin ? 'Admin' : 'Employee',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      ],
    );
  }
}

// ==================== TODAY ATTENDANCE ====================
class TodayAttendanceCard extends ConsumerWidget {
  final String uid;

  const TodayAttendanceCard({
    super.key,
    required this.uid,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayAttendance = ref.watch(todayAttendanceProvider(uid));

    return Card(
      elevation: 0,
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: todayAttendance.when(
          data: (record) => _TodayAttendanceBody(
            record: record,
            onCheckIn: () =>
                ref.read(attendanceNotifierProvider.notifier).checkIn(uid),
            onCheckOut: () =>
                ref.read(attendanceNotifierProvider.notifier).checkOut(uid),
          ),
          loading: () => const SizedBox(
            height: 120,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (_, __) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Today's Attendance",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                'Unable to load attendance right now. Please try again.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TodayAttendanceBody extends StatelessWidget {
  final AttendanceRecord? record;
  final VoidCallback onCheckIn;
  final VoidCallback onCheckOut;

  const _TodayAttendanceBody({
    required this.record,
    required this.onCheckIn,
    required this.onCheckOut,
  });

  @override
  Widget build(BuildContext context) {
    final checkedIn = record?.isCheckedIn == true;
    final completed = record?.isCheckedOut == true;
    final Color accent;
    final IconData icon;
    final String title;
    final String subtitle;

    if (record == null || !record!.hasAttendance) {
      accent = AppColors.deepIndigo;
      icon = Icons.login_rounded;
      title = 'Not checked in';
      subtitle = 'Tap below to start your day';
    } else if (checkedIn) {
      accent = AppColors.warning;
      icon = Icons.timer_outlined;
      title = 'Checked in';
      subtitle = record!.checkIn != null
          ? 'Since ${DateFormat('hh:mm a').format(record!.checkIn!)}'
          : 'Currently on duty';
    } else {
      accent = AppColors.success;
      icon = Icons.check_circle_outline;
      title = 'Checked out';
      final hours = record!.totalHours;
      subtitle = hours != null
          ? '${hours.inHours}h ${hours.inMinutes % 60}m worked today'
          : 'Day complete';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: accent, size: 28),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today's Attendance",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (!completed) ...[
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: checkedIn ? onCheckOut : onCheckIn,
              icon: Icon(checkedIn ? Icons.logout_rounded : Icons.login_rounded),
              label: Text(checkedIn ? 'Check Out' : 'Check In'),
              style: FilledButton.styleFrom(
                backgroundColor: checkedIn ? AppColors.warning : AppColors.success,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// ==================== QUICK LINKS ====================
class QuickActionsWidget extends StatelessWidget {
  const QuickActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = <_QuickAction>[
      _QuickAction(
        title: 'Attendance',
        subtitle: 'Check in & history',
        icon: Icons.access_time_rounded,
        color: AppColors.deepIndigo,
        screen: const AttendanceScreen(),
      ),
      _QuickAction(
        title: 'Leave',
        subtitle: 'Apply & track',
        icon: Icons.event_busy_rounded,
        color: AppColors.warning,
        screen: const LeaveScreen(),
      ),
      _QuickAction(
        title: 'Salary',
        subtitle: 'Overview & requests',
        icon: Icons.account_balance_wallet_rounded,
        color: AppColors.success,
        screen: const SalaryScreen(),
      ),
      _QuickAction(
        title: 'Profile',
        subtitle: 'Your details',
        icon: Icons.person_rounded,
        color: AppColors.indigoBlue,
        screen: const StaffProfileScreen(),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Links',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.35,
          children: actions
              .map(
                (a) => _ActionCard(
                  title: a.title,
                  subtitle: a.subtitle,
                  icon: a.icon,
                  color: a.color,
                  screen: a.screen,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _QuickAction {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Widget screen;

  const _QuickAction({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.screen,
  });
}

class _ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Widget screen;

  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => screen),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
            color: AppColors.surfaceAlt,
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 22),
                ),
                const Spacer(),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

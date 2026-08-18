import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../config/colors.dart';
import '../../models/attendance_record.dart';
import '../../providers/app_providers.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/status_badge.dart';

class AttendanceScreen extends ConsumerWidget {
  final bool embedded;

  const AttendanceScreen({super.key, this.embedded = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    final uid = user?.id ?? '';
    final todayAttendance = ref.watch(todayAttendanceProvider(uid));
    final history = ref.watch(attendanceHistoryProvider(uid));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Attendance'),
        automaticallyImplyLeading: !embedded,
      ),
      body: user == null
          ? const Center(
              child: Text(
                'Please sign in to view attendance.',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTodayCard(context, todayAttendance, ref, uid),
                  const SizedBox(height: 20),
                  _buildStats(context, history),
                  const SizedBox(height: 24),
                  Text(
                    'History',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 12),
                  _buildHistoryList(context, ref, uid, history),
                ],
              ),
            ),
    );
  }

  Widget _buildTodayCard(
    BuildContext context,
    AsyncValue<AttendanceRecord?> attendance,
    WidgetRef ref,
    String uid,
  ) {
    return Card(
      elevation: 0,
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.deepIndigo.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.access_time_filled_rounded,
                size: 36,
                color: AppColors.deepIndigo,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              "Today's Status",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
            ),
            const SizedBox(height: 16),
            attendance.when(
              data: (record) {
                if (record == null || !record.hasAttendance) {
                  return Column(
                    children: [
                      const Text(
                        'Not checked in yet',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: () => ref
                              .read(attendanceNotifierProvider.notifier)
                              .checkIn(uid),
                          icon: const Icon(Icons.login_rounded),
                          label: const Text('Check In Now'),
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.success,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (record.isCheckedIn) {
                  return Column(
                    children: [
                      _statusBadgeForRecord(record),
                      const SizedBox(height: 8),
                      Text(
                        record.checkIn != null
                            ? 'In at ${DateFormat('hh:mm a').format(record.checkIn!)}'
                            : 'Checked in',
                        style: const TextStyle(color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: () => ref
                              .read(attendanceNotifierProvider.notifier)
                              .checkOut(uid),
                          icon: const Icon(Icons.logout_rounded),
                          label: const Text('Check Out'),
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.warning,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  final hours = record.totalHours;
                  return Column(
                    children: [
                      _statusBadgeForRecord(record),
                      const SizedBox(height: 8),
                      Text(
                        hours != null
                            ? '${hours.inHours}h ${hours.inMinutes % 60}m worked'
                            : 'Check-out complete',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                      ),
                      if (record.checkIn != null && record.checkOut != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            '${DateFormat('hh:mm a').format(record.checkIn!)} – ${DateFormat('hh:mm a').format(record.checkOut!)}',
                            style: const TextStyle(color: AppColors.textSecondary),
                          ),
                        ),
                    ],
                  );
                }
              },
              loading: () => const Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
              error: (_, __) => const Text(
                'Unable to load today\'s attendance. Please try again.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStats(BuildContext context, AsyncValue<List<AttendanceRecord>> history) {
    return Card(
      elevation: 0,
      color: AppColors.surfaceAlt,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This Month',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
            ),
            const SizedBox(height: 16),
            history.when(
              data: (records) {
                final present = records.where((r) => r.hasAttendance).length;
                final total = records.length;
                final percentage = total > 0 ? (present / total) * 100 : 0.0;
                return Row(
                  children: [
                    Expanded(
                      child: _StatTile(
                        label: 'Present',
                        value: '$present',
                        color: AppColors.success,
                        icon: Icons.check_circle_outline,
                      ),
                    ),
                    Expanded(
                      child: _StatTile(
                        label: 'Records',
                        value: '$total',
                        color: AppColors.deepIndigo,
                        icon: Icons.calendar_month_outlined,
                      ),
                    ),
                    Expanded(
                      child: _StatTile(
                        label: 'Rate',
                        value: '${percentage.toStringAsFixed(0)}%',
                        color: AppColors.warning,
                        icon: Icons.trending_up_rounded,
                      ),
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => const Text(
                'Unable to load attendance stats.',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryList(
    BuildContext context,
    WidgetRef ref,
    String uid,
    AsyncValue<List<AttendanceRecord>> history,
  ) {
    final leavesAsync = ref.watch(myLeavesProvider(uid));
    final leaveDates = <String>{};
    leavesAsync.whenData((leaves) {
      for (final leave in leaves) {
        if (!leave.isApproved) continue;
        var day = DateTime(
          leave.startDate.year,
          leave.startDate.month,
          leave.startDate.day,
        );
        final end = DateTime(
          leave.endDate.year,
          leave.endDate.month,
          leave.endDate.day,
        );
        while (!day.isAfter(end)) {
          leaveDates.add(DateFormat('yyyy-MM-dd').format(day));
          day = day.add(const Duration(days: 1));
        }
      }
    });

    return history.when(
      data: (records) {
        if (records.isEmpty) {
          return const EmptyState(
            icon: Icons.history_toggle_off_rounded,
            title: 'No attendance yet',
            subtitle: 'Your daily check-ins will appear here.',
          );
        }
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: records.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final record = records[index];
            final onLeave = leaveDates.contains(record.date);
            return _AttendanceHistoryCard(record: record, onLeave: onLeave);
          },
        );
      },
      loading: () => const SizedBox(
        height: 120,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (_, __) => const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Text(
          'Unable to load attendance history. Please try again.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textSecondary),
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData icon;

  const _StatTile({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      ],
    );
  }
}

class _AttendanceHistoryCard extends StatelessWidget {
  final AttendanceRecord record;
  final bool onLeave;

  const _AttendanceHistoryCard({
    required this.record,
    this.onLeave = false,
  });

  @override
  Widget build(BuildContext context) {
    DateTime? parsedDate;
    try {
      parsedDate = DateTime.parse(record.date);
    } catch (_) {}

    final dateLabel = parsedDate != null
        ? DateFormat('EEE, MMM d').format(parsedDate)
        : record.date;

    final timeLabel = onLeave && !record.hasAttendance
        ? 'On approved leave'
        : record.checkIn == null
            ? 'No check-in'
            : '${DateFormat('hh:mm a').format(record.checkIn!)}'
                '${record.checkOut != null ? ' – ${DateFormat('hh:mm a').format(record.checkOut!)}' : ' – Ongoing'}';

    final hours = record.totalHours;
    final hoursLabel = hours != null
        ? '${hours.inHours}h ${hours.inMinutes % 60}m'
        : '—';

    return Card(
      elevation: 0,
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dateLabel,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    timeLabel,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _statusBadgeForRecord(record, onLeave: onLeave),
                const SizedBox(height: 6),
                Text(
                  hoursLabel,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _statusBadgeForRecord(AttendanceRecord record, {bool onLeave = false}) {
  final label = _attendanceStatusLabel(record, onLeave: onLeave);
  switch (label) {
    case 'Present':
      return StatusBadge.success(label: 'Present', icon: Icons.check_circle);
    case 'Late':
      return StatusBadge.warning(label: 'Late', icon: Icons.schedule);
    case 'Leave':
      return StatusBadge.info(label: 'Leave', icon: Icons.beach_access);
    case 'Absent':
    default:
      return StatusBadge.error(label: 'Absent', icon: Icons.cancel);
  }
}

String _attendanceStatusLabel(AttendanceRecord record, {bool onLeave = false}) {
  if (onLeave && !record.hasAttendance) {
    return 'Leave';
  }
  if (!record.hasAttendance || record.status == AttendanceStatus.absent) {
    return 'Absent';
  }
  if (record.status == AttendanceStatus.halfDay) {
    return 'Late';
  }
  final checkIn = record.checkIn;
  if (checkIn != null) {
    final minutes = checkIn.hour * 60 + checkIn.minute;
    // Treat check-in after 9:15 as late.
    if (minutes > (9 * 60 + 15)) {
      return 'Late';
    }
  }
  return 'Present';
}

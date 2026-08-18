import 'package:flutter/material.dart';
import '../../models/attendance_record.dart';
import 'package:intl/intl.dart';

class AttendanceStatusCard extends StatelessWidget {
  final AttendanceRecord? record;
  final VoidCallback? onCheckIn;
  final VoidCallback? onCheckOut;

  const AttendanceStatusCard({
    super.key,
    this.record,
    this.onCheckIn,
    this.onCheckOut,
  });

  IconData get icon {
    if (record == null) return Icons.login;
    if (record!.isCheckedIn) return Icons.timer;
    return Icons.check_circle;
  }

  Color get color {
    if (record == null) return Colors.green;
    if (record!.isCheckedIn) return Colors.orange;
    return Colors.green;
  }

  String get statusText {
    if (record == null) return 'Check In';
    if (record!.isCheckedIn) return 'Checked In';
    return 'Completed';
  }

  String get subtitle {
    if (record?.checkIn == null) return '';
    if (record!.isCheckedIn) {
      return DateFormat('HH:mm').format(record!.checkIn!);
    }
    return '${record!.totalHours?.inHours ?? 0}h';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 32, color: color),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(statusText, style: Theme.of(context).textTheme.titleLarge),
                  Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
            if (onCheckIn != null && record == null) ...[
              ElevatedButton.icon(
                onPressed: onCheckIn,
                icon: const Icon(Icons.login, size: 16),
                label: const Text('Check In'),
              ),
            ] else if (onCheckOut != null && record!.isCheckedIn) ...[
              ElevatedButton.icon(
                onPressed: onCheckOut,
                icon: const Icon(Icons.logout, size: 16),
                label: const Text('Check Out'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

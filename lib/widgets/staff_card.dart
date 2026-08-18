import 'package:flutter/material.dart';
import '../config/colors.dart';
import '../models/user.dart';
import 'status_badge.dart';

class StaffCard extends StatelessWidget {
  final User staff;
  final VoidCallback? onTap;
  final VoidCallback? onProfileTap;
  final VoidCallback? onAttendanceTap;
  final VoidCallback? onSalaryTap;
  final VoidCallback? onLeaveTap;
  final bool showActions;

  const StaffCard({
    super.key,
    required this.staff,
    this.onTap,
    this.onProfileTap,
    this.onAttendanceTap,
    this.onSalaryTap,
    this.onLeaveTap,
    this.showActions = true,
  });

  @override
  Widget build(BuildContext context) {
    final roleLabel = staff.isAdmin ? 'Admin' : 'Employee';
    final initial = staff.name.isNotEmpty ? staff.name[0].toUpperCase() : '?';

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 1,
      shadowColor: Colors.black.withValues(alpha: 0.06),
      child: InkWell(
        onTap: onTap ?? onProfileTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.deepIndigo.withValues(alpha: 0.12),
                    child: Text(
                      initial,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.deepIndigo,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          staff.name,
                          style: Theme.of(context).textTheme.titleLarge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          roleLabel,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        if (staff.phone != null && staff.phone!.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text(
                            staff.phone!,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ],
                    ),
                  ),
                  StatusBadge.success(label: 'Active', icon: Icons.check_circle),
                ],
              ),
              if (staff.salary != null) ...[
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceAlt,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Monthly Salary', style: Theme.of(context).textTheme.bodySmall),
                      Text(
                        'Rs. ${staff.salary!.toStringAsFixed(0)}',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.deepIndigo,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
              if (showActions) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    if (onProfileTap != null)
                      _ActionChip(label: 'Profile', onPressed: onProfileTap!),
                    if (onAttendanceTap != null)
                      _ActionChip(label: 'Attendance', onPressed: onAttendanceTap!),
                    if (onSalaryTap != null)
                      _ActionChip(label: 'Salary', onPressed: onSalaryTap!),
                    if (onLeaveTap != null)
                      _ActionChip(label: 'Leave', onPressed: onLeaveTap!),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _ActionChip({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }
}

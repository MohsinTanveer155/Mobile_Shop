import 'package:flutter/material.dart';
import '../config/colors.dart';

class StatusBadge extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;
  final double borderRadius;

  const StatusBadge({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    this.icon,
    this.borderRadius = 20,
  });

  factory StatusBadge.success({
    required String label,
    IconData? icon,
  }) {
    return StatusBadge(
      label: label,
      backgroundColor: AppColors.success.withValues(alpha: 0.1),
      textColor: AppColors.success,
      icon: icon,
    );
  }

  factory StatusBadge.error({
    required String label,
    IconData? icon,
  }) {
    return StatusBadge(
      label: label,
      backgroundColor: AppColors.error.withValues(alpha: 0.1),
      textColor: AppColors.error,
      icon: icon,
    );
  }

  factory StatusBadge.warning({
    required String label,
    IconData? icon,
  }) {
    return StatusBadge(
      label: label,
      backgroundColor: AppColors.warning.withValues(alpha: 0.1),
      textColor: AppColors.warning,
      icon: icon,
    );
  }

  factory StatusBadge.info({
    required String label,
    IconData? icon,
  }) {
    return StatusBadge(
      label: label,
      backgroundColor: AppColors.cyan.withValues(alpha: 0.1),
      textColor: AppColors.cyan,
      icon: icon,
    );
  }

  factory StatusBadge.pending({
    required String label,
    IconData? icon,
  }) {
    return StatusBadge(
      label: label,
      backgroundColor: AppColors.warning.withValues(alpha: 0.1),
      textColor: AppColors.warning,
      icon: icon ?? Icons.schedule,
    );
  }

  factory StatusBadge.approved({
    required String label,
    IconData? icon,
  }) {
    return StatusBadge(
      label: label,
      backgroundColor: AppColors.success.withValues(alpha: 0.1),
      textColor: AppColors.success,
      icon: icon ?? Icons.check_circle,
    );
  }

  factory StatusBadge.rejected({
    required String label,
    IconData? icon,
  }) {
    return StatusBadge(
      label: label,
      backgroundColor: AppColors.error.withValues(alpha: 0.1),
      textColor: AppColors.error,
      icon: icon ?? Icons.cancel,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: textColor),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

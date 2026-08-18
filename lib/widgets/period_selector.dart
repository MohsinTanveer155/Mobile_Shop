import 'package:flutter/material.dart';
import '../services/report_service.dart';

/// Segmented button widget for selecting report periods.
/// Supports Daily, Weekly, Monthly, and Yearly views.
class PeriodSelector extends StatelessWidget {
  final ReportPeriod selectedPeriod;
  final Function(ReportPeriod) onPeriodChanged;

  const PeriodSelector({
    super.key,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<ReportPeriod>(
      segments: const [
        ButtonSegment(
          value: ReportPeriod.daily,
          label: Text('Daily'),
          icon: Icon(Icons.today),
        ),
        ButtonSegment(
          value: ReportPeriod.weekly,
          label: Text('Weekly'),
          icon: Icon(Icons.calendar_view_week),
        ),
        ButtonSegment(
          value: ReportPeriod.monthly,
          label: Text('Monthly'),
          icon: Icon(Icons.calendar_month),
        ),
        ButtonSegment(
          value: ReportPeriod.yearly,
          label: Text('Yearly'),
          icon: Icon(Icons.calendar_today),
        ),
      ],
      selected: {selectedPeriod},
      onSelectionChanged: (Set<ReportPeriod> newSelection) {
        onPeriodChanged(newSelection.first);
      },
    );
  }
}


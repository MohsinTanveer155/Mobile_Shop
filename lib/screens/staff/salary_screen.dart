import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_shop/gen/l10n/app_localizations.dart';

import '../../config/colors.dart';
import '../../models/salary_record.dart';
import '../../models/user.dart';
import '../../providers/app_providers.dart';
import '../../providers/settings_provider.dart';
import '../../utils/currency_formatter.dart';
import '../../widgets/empty_state.dart';
import 'admin_salary_requests_screen.dart';
import 'salary_request_screen.dart';

class SalaryScreen extends ConsumerWidget {
  final bool embedded;

  const SalaryScreen({super.key, this.embedded = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final user = ref.watch(authProvider);

    if (user == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(l10n.salary),
          automaticallyImplyLeading: !embedded,
        ),
        body: Center(
          child: Text(
            l10n.pleaseSignInToViewSalary,
            style: const TextStyle(color: AppColors.textSecondary),
          ),
        ),
      );
    }

    final salaryHistory = ref.watch(salaryHistoryProvider(user.id));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.salary),
        automaticallyImplyLeading: !embedded,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.salaryOverview,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
              ),
              const SizedBox(height: 12),
              _buildCurrentPreview(context, ref, user),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: user.isAdmin
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          FilledButton.icon(
                            onPressed: () => _generatePayroll(context, ref, user),
                            icon: const Icon(Icons.calculate_outlined),
                            label: Text(l10n.generatePayroll),
                            style: FilledButton.styleFrom(
                              backgroundColor: AppColors.deepIndigo,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          OutlinedButton.icon(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AdminSalaryRequestsScreen(),
                              ),
                            ),
                            icon: const Icon(Icons.request_page_outlined),
                            label: Text(l10n.manageSalaryRequests),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.deepIndigo,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              side: const BorderSide(color: AppColors.border),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      )
                    : FilledButton.icon(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SalaryRequestScreen(),
                          ),
                        ),
                        icon: const Icon(Icons.send_rounded),
                        label: Text(l10n.requestSalary),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.deepIndigo,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 28),
              Text(
                l10n.salaryHistory,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
              ),
              const SizedBox(height: 12),
              salaryHistory.when(
                data: (records) {
                  if (records.isEmpty) {
                    return EmptyState(
                      icon: Icons.account_balance_wallet_outlined,
                      title: l10n.noSalaryRecords,
                      subtitle: l10n.noSalaryRecordsSubtitle,
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: records.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final record = records[index];
                      return _SalaryHistoryCard(record: record);
                    },
                  );
                },
                loading: () => const SizedBox(
                  height: 160,
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (_, __) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                    l10n.unableToLoadSalaryHistory,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentPreview(BuildContext context, WidgetRef ref, User user) {
    final l10n = AppLocalizations.of(context);
    final currency = ref.watch(currencyProvider);

    return ref.watch(currentSalaryPreviewProvider(user.id)).when(
          data: (record) {
            final basic = record?.baseSalary ?? user.salary ?? 0;
            final presentDays = record?.presentDays ?? 0;
            final workingDays = record?.totalWorkingDays ?? 26;
            final estimated = record?.netPay ?? basic;
            final attendancePct = record?.attendancePercentage ?? 0;
            final deductions = record?.deductions ?? 0;

            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _OverviewTile(
                        label: l10n.basicSalary,
                        value: CurrencyFormatter.format(basic, currency),
                        icon: Icons.payments_outlined,
                        color: AppColors.deepIndigo,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _OverviewTile(
                        label: l10n.presentDays,
                        value: '$presentDays / $workingDays',
                        icon: Icons.event_available_outlined,
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _OverviewTile(
                        label: l10n.estimatedPay,
                        value: CurrencyFormatter.format(estimated, currency),
                        icon: Icons.trending_up_rounded,
                        color: AppColors.indigoBlue,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _OverviewTile(
                        label: l10n.attendance,
                        value: '${attendancePct.toStringAsFixed(0)}%',
                        icon: Icons.pie_chart_outline_rounded,
                        color: AppColors.warning,
                      ),
                    ),
                  ],
                ),
                if (deductions > 0) ...[
                  const SizedBox(height: 12),
                  _OverviewTile(
                    label: l10n.deductions,
                    value: CurrencyFormatter.format(deductions, currency),
                    icon: Icons.remove_circle_outline,
                    color: AppColors.error,
                  ),
                ],
              ],
            );
          },
          loading: () => const SizedBox(
            height: 140,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (_, __) => Card(
            elevation: 0,
            color: AppColors.surfaceAlt,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: const BorderSide(color: AppColors.border),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                l10n.unableToLoadSalaryPreview,
                style: const TextStyle(color: AppColors.textSecondary),
              ),
            ),
          ),
        );
  }

  void _generatePayroll(BuildContext context, WidgetRef ref, User user) {
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.payrollGenerated)),
    );
  }
}

class _OverviewTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _OverviewTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: color),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SalaryHistoryCard extends ConsumerWidget {
  final SalaryRecord record;

  const _SalaryHistoryCard({required this.record});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final currency = ref.watch(currencyProvider);

    return Card(
      elevation: 0,
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.deepIndigo.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.account_balance_wallet_outlined,
              color: AppColors.deepIndigo,
              size: 22,
            ),
          ),
          title: Text(
            l10n.monthYearSalary(record.monthYear),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
          ),
          subtitle: Text(
            '${l10n.netPay}: ${CurrencyFormatter.format(record.netPay, currency)}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surfaceAlt,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _SalaryDetailRow(
                    label: l10n.baseSalary,
                    value: CurrencyFormatter.format(record.baseSalary, currency),
                  ),
                  _SalaryDetailRow(
                    label: l10n.presentDays,
                    value: '${record.presentDays}/${record.totalWorkingDays}',
                  ),
                  _SalaryDetailRow(
                    label: l10n.attendancePercentage,
                    value: '${record.attendancePercentage.toStringAsFixed(0)}%',
                  ),
                  _SalaryDetailRow(
                    label: l10n.deductions,
                    value: CurrencyFormatter.format(record.deductions, currency),
                  ),
                  _SalaryDetailRow(
                    label: l10n.netPay,
                    value: CurrencyFormatter.format(record.netPay, currency),
                    isBold: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SalaryDetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const _SalaryDetailRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
              fontSize: isBold ? 16 : 14,
            ),
          ),
        ],
      ),
    );
  }
}
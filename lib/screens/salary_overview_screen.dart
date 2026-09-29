import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../config/colors.dart';
import '../gen/l10n/app_localizations.dart';
import '../models/salary_request.dart';
import '../providers/app_providers.dart';
import '../widgets/empty_state.dart';
import '../widgets/loading_state.dart';
import 'salary_request_screen.dart';

class SalaryOverviewScreen extends ConsumerWidget {
  const SalaryOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    final l10n = AppLocalizations.of(context);

    void goToRequestScreen() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SalaryRequestScreen()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.salaryOverview),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: goToRequestScreen,
        icon: const Icon(Icons.add),
        label: Text(l10n.requestSalary),
      ),
      body: user == null
          ? EmptyState(
              icon: Icons.login,
              title: l10n.accessDenied,
              subtitle: l10n.pleaseSignInToViewSalary,
            )
          : RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(staffSalaryRequestsProvider);
                await Future.delayed(const Duration(milliseconds: 300));
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.salaryRequests, style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 16),
                    ref.watch(staffSalaryRequestsProvider).when(
                          loading: () => const LoadingState(fullScreen: false),
                          error: (err, stack) => EmptyState(
                            icon: Icons.error_outline,
                            title: l10n.accessDenied,
                            subtitle: l10n.unableToLoadSalaryHistory,
                            iconColor: AppColors.error,
                            actionLabel: l10n.goBack,
                            onActionPressed: () => ref.invalidate(staffSalaryRequestsProvider),
                          ),
                          data: (requests) {
                            if (requests.isEmpty) {
                              return EmptyState(
                                icon: Icons.request_quote,
                                title: l10n.noSalaryRequestsYet,
                                subtitle: l10n.noSalaryRecordsSubtitle,
                                actionLabel: l10n.requestSalary,
                                onActionPressed: goToRequestScreen,
                              );
                            }
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: requests.length,
                              itemBuilder: (context, index) {
                                final request = requests[index];
                                return Card(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${l10n.amount}: Rs ${request.amount.toStringAsFixed(2)}',
                                              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                            ),
                                            _buildStatusChip(l10n, request.status),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          l10n.requestedDate(DateFormat('dd MMM yyyy').format(request.requestDate)),
                                          style: Theme.of(context).textTheme.bodySmall,
                                        ),
                                        if (request.adminRemark != null && request.adminRemark!.isNotEmpty)
                                          Padding(
                                            padding: const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              l10n.adminNote(request.adminRemark!),
                                              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildStatusChip(AppLocalizations l10n, SalaryRequestStatus status) {
    Color color;
    String label;
    switch (status) {
      case SalaryRequestStatus.pending:
        color = AppColors.warning;
        label = l10n.pending;
        break;
      case SalaryRequestStatus.approved:
        color = AppColors.success;
        label = l10n.approved;
        break;
      case SalaryRequestStatus.rejected:
        color = AppColors.error;
        label = l10n.rejected;
        break;
    }
    return Chip(
      label: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      backgroundColor: color,
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
    );
  }
}

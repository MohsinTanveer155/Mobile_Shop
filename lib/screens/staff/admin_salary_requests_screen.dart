import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mobile_shop/gen/l10n/app_localizations.dart';
import 'package:mobile_shop/providers/settings_provider.dart';
import 'package:mobile_shop/utils/currency_formatter.dart';

import '../../models/salary_request.dart';
import '../../providers/app_providers.dart';
import '../../widgets/role_guard.dart';

class AdminSalaryRequestsScreen extends ConsumerWidget {
  const AdminSalaryRequestsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final currency = ref.watch(currencyProvider);

    return RoleGuard(
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.salaryRequests)),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ref.watch(adminSalaryRequestsProvider).when(
                data: (requests) {
                  if (requests.isEmpty) {
                    return Center(child: Text(l10n.noPendingSalaryRequests));
                  }
                  return ListView.separated(
                    itemCount: requests.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final request = requests[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    request.staffName,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    DateFormat.yMMMd()
                                        .format(request.requestDate),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${l10n.amount}: ${CurrencyFormatter.format(request.amount, currency)}',
                              ),
                              const SizedBox(height: 6),
                              Text('${l10n.reason}: ${request.reason}'),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () => _showUpdateDialog(
                                        context,
                                        ref,
                                        request,
                                        'rejected',
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.red,
                                      ),
                                      child: Text(l10n.reject),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () => _showUpdateDialog(
                                        context,
                                        ref,
                                        request,
                                        'approved',
                                      ),
                                      child: Text(l10n.approve),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
              ),
        ),
      ),
    );
  }

  void _showUpdateDialog(
    BuildContext context,
    WidgetRef ref,
    SalaryRequest request,
    String status,
  ) {
    final l10n = AppLocalizations.of(context);
    final remarkController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          status == 'approved' ? l10n.approveRequest : l10n.rejectRequest,
        ),
        content: TextFormField(
          controller: remarkController,
          maxLines: 4,
          decoration: InputDecoration(
            labelText: l10n.adminRemark,
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () async {
              final remarkText = remarkController.text.trim();
              final pageContext = context;
              final statusLabel = status == 'approved'
                  ? l10n.approve.toLowerCase()
                  : l10n.reject.toLowerCase();
              final successMessage =
                  l10n.requestStatusSuccessfully(statusLabel);

              try {
                await ref
                    .read(salaryServiceProvider)
                    .updateSalaryRequestStatus(
                      requestId: request.id,
                      status: status == 'approved'
                          ? SalaryRequestStatus.approved
                          : SalaryRequestStatus.rejected,
                      adminRemark: remarkText.isEmpty ? null : remarkText,
                    );

                if (!pageContext.mounted) return;
                ref.invalidate(adminSalaryRequestsProvider);
                if (Navigator.of(dialogContext).canPop()) {
                  Navigator.of(dialogContext).pop();
                }
                remarkController.dispose();
                ScaffoldMessenger.maybeOf(pageContext)?.showSnackBar(
                  SnackBar(content: Text(successMessage)),
                );
              } catch (e) {
                if (!pageContext.mounted) return;
                if (Navigator.of(dialogContext).canPop()) {
                  Navigator.of(dialogContext).pop();
                }
                remarkController.dispose();
                ScaffoldMessenger.maybeOf(pageContext)?.showSnackBar(
                  SnackBar(
                    content: Text('Failed to update: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: Text(l10n.submit),
          ),
        ],
      ),
    );
  }
}
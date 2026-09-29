import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../config/colors.dart';
import '../gen/l10n/app_localizations.dart';
import '../models/salary_request.dart';
import '../providers/app_providers.dart';
import '../widgets/empty_state.dart';
import '../widgets/loading_state.dart';
import '../widgets/role_guard.dart';

class AdminSalaryRequestsScreen extends ConsumerWidget {
  const AdminSalaryRequestsScreen({super.key});

  Future<void> _showManageRequestDialog(BuildContext context, WidgetRef ref, SalaryRequest request) async {
    final TextEditingController remarkController = TextEditingController(text: request.adminRemark);
    final AppLocalizations l10n = AppLocalizations.of(context);

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(l10n.manageSalaryRequests),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${l10n.staffName}: ${request.staffName}'),
                Text('${l10n.amount}: Rs ${request.amount.toStringAsFixed(2)}'),
                Text('${l10n.requestDate}: ${DateFormat('dd MMM yyyy').format(request.requestDate)}'),
                const SizedBox(height: 16),
                TextField(
                  controller: remarkController,
                  decoration: InputDecoration(
                    labelText: l10n.adminRemark, // 'Admin Remark'
                    hintText: l10n.notesOptional, // 'Notes (Optional)'
                    border: const OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(l10n.cancel),
            ),
            ElevatedButton(
              onPressed: () => _updateRequestStatus(
                dialogContext,
                ref,
                request.id,
                SalaryRequestStatus.rejected,
                remarkController.text.trim(),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
              child: Text(l10n.reject),
            ),
            ElevatedButton(
              onPressed: () => _updateRequestStatus(
                dialogContext,
                ref,
                request.id,
                SalaryRequestStatus.approved,
                remarkController.text.trim(),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.success),
              child: Text(l10n.approve),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateRequestStatus(
    BuildContext context,
    WidgetRef ref,
    String requestId,
    SalaryRequestStatus status,
    String remark,
  ) async {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final parentContext = context;

    try {
      final salaryService = ref.read(salaryServiceProvider);
      await salaryService.updateSalaryRequestStatus(
        requestId: requestId,
        status: status,
        adminRemark: remark.isNotEmpty ? remark : null,
      );

      ref.invalidate(adminSalaryRequestsProvider);

      if (!parentContext.mounted) return;
      if (Navigator.of(parentContext).canPop()) {
        Navigator.of(parentContext).pop();
      }
      ScaffoldMessenger.maybeOf(parentContext)?.showSnackBar(
        SnackBar(
          content: Text(l10n.requestStatusSuccessfully(status.name)),
          backgroundColor: AppColors.success,
        ),
      );
    } catch (e) {
      if (!parentContext.mounted) return;
      if (Navigator.of(parentContext).canPop()) {
        Navigator.of(parentContext).pop();
      }
      ScaffoldMessenger.maybeOf(parentContext)?.showSnackBar(
        SnackBar(
          content: Text(l10n.errorGeneric(e.toString())),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adminRequestsAsync = ref.watch(adminSalaryRequestsProvider);
    final AppLocalizations l10n = AppLocalizations.of(context);

    return RoleGuard(
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.manageSalaryRequests),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(adminSalaryRequestsProvider);
            await Future.delayed(const Duration(milliseconds: 300));
          },
          child: adminRequestsAsync.when(
            loading: () => LoadingState(message: l10n.loadingDashboard),
            error: (err, stack) => EmptyState(
              icon: Icons.error_outline,
              title: l10n.accessDenied,
              subtitle: l10n.unableToLoadSalaryHistory,
              iconColor: AppColors.error,
              actionLabel: l10n.goBack,
              onActionPressed: () => ref.invalidate(adminSalaryRequestsProvider),
            ),
            data: (requests) {
              if (requests.isEmpty) {
                return EmptyState(
                  icon: Icons.request_quote,
                  title: l10n.noPendingSalaryRequests,
                  subtitle: l10n.noSalaryRecordsSubtitle,
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: requests.length,
                itemBuilder: (context, index) {
                  final request = requests[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Text(request.staffName, style: Theme.of(context).textTheme.titleMedium),
                      subtitle: Text(
                        '${l10n.amount}: Rs ${request.amount.toStringAsFixed(2)}\n'
                        '${l10n.requestDate}: ${DateFormat('dd MMM yyyy').format(request.requestDate)}',
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () => _showManageRequestDialog(context, ref, request),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
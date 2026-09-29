import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../../config/colors.dart';
import '../../gen/l10n/app_localizations.dart';
import '../../models/salary_request.dart';
import '../../providers/app_providers.dart';
import '../../utils/validators.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/loading_state.dart';

class SalaryRequestScreen extends ConsumerStatefulWidget {
  const SalaryRequestScreen({super.key});

  @override
  ConsumerState<SalaryRequestScreen> createState() => _SalaryRequestScreenState();
}

class _SalaryRequestScreenState extends ConsumerState<SalaryRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _amountController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _submitRequest() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    final user = ref.read(authProvider);
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).pleaseSignInSalaryRequests)),
      );
      setState(() => _isLoading = false);
      return;
    }

    final amount = double.tryParse(_amountController.text.trim());
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).errorGeneric('Invalid amount'))),
      );
      setState(() => _isLoading = false);
      return;
    }

    final newRequest = SalaryRequest(
      staffId: user.id,
      staffName: user.name,
      amount: amount,
      reason: _reasonController.text.trim(),
      requestDate: DateTime.now(),
      createdAt: DateTime.now(),
      status: SalaryRequestStatus.pending,
    );

    try {
      final salaryService = ref.read(salaryServiceProvider);
      await salaryService.createSalaryRequest(newRequest);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).salaryRequestSubmitted),
          backgroundColor: AppColors.success,
        ),
      );
      Navigator.pop(context); // Go back after successful submission
    } catch (e) {
      if (!mounted) return;
      final message = e is FirebaseException && e.code == 'permission-denied'
          ? 'You do not have permission to submit this salary request.'
          : e is FirebaseAuthException && e.code == 'unauthenticated'
              ? AppLocalizations.of(context).pleaseSignInSalaryRequests
              : 'Unable to submit salary request. Please check your connection and try again.';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final user = ref.watch(authProvider);

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.requestSalary)),
        body: EmptyState(
          icon: Icons.login,
          title: l10n.accessDenied,
          subtitle: l10n.pleaseSignInSalaryRequests,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.requestSalary)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(l10n.newSalaryRequest, style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _amountController,
                        decoration: InputDecoration(labelText: l10n.amount, prefixText: 'Rs '),
                        keyboardType: TextInputType.number,
                        validator: (v) => Validators.validateNumber(v, fieldName: l10n.amount, minValue: 1),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _reasonController,
                        decoration: InputDecoration(labelText: l10n.reason, hintText: l10n.notesOptional),
                        minLines: 2,
                        maxLines: 4,
                        validator: (v) => Validators.validateRequired(v, l10n.reason),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _isLoading ? null : _submitRequest,
                        child: _isLoading
                            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                            : Text(l10n.sendRequest),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(l10n.requestHistory, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            ref.watch(staffSalaryRequestsProvider).when(
                  data: (requests) {
                    if (requests.isEmpty) {
                      return EmptyState(icon: Icons.history, title: l10n.noSalaryRequestsYet, subtitle: l10n.noSalaryRecordsSubtitle);
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: requests.length,
                      itemBuilder: (context, index) {
                        final item = requests[index];
                        return Card(
                          child: ListTile(
                            title: Text('${l10n.amount}: Rs ${item.amount.toStringAsFixed(0)}'),
                            subtitle: Text('${l10n.requestedDate(DateFormat.yMMMd().format(item.requestDate))}\nReason: ${item.reason}'),
                            trailing: Chip(
                              label: Text(item.status.name),
                              backgroundColor: item.status == SalaryRequestStatus.approved
                                  ? AppColors.success.withAlpha(50)
                                  : item.status == SalaryRequestStatus.rejected
                                      ? AppColors.error.withAlpha(50)
                                      : AppColors.warning.withAlpha(50),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  loading: () => const LoadingState(fullScreen: false),
                  error: (e, _) => Text('Error: $e'),
                ),
          ],
        ),
      ),
    );
  }
}

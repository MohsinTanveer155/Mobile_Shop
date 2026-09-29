import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/colors.dart';
import '../gen/l10n/app_localizations.dart';
import '../models/salary_request.dart';
import '../providers/app_providers.dart';
import '../utils/validators.dart';

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

    final appUser = ref.read(authProvider);
    if (appUser == null) {
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
      staffId: appUser.id,
      staffName: appUser.name,
      amount: amount,
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).salaryRequestFailed(e.toString())),
          backgroundColor: AppColors.error,
        ),
      );
    }

    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).requestSalary),
      ),
      body: SafeArea( // Ensures content is not obscured by system UI
        child: SingleChildScrollView( // Handles overflow, especially with keyboard
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).amount,
                    prefixText: 'Rs ',
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) => Validators.validateNumber(value, fieldName: AppLocalizations.of(context).amount, minValue: 1),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _reasonController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).reason,
                    hintText: AppLocalizations.of(context).notesOptional,
                    border: const OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) => Validators.validateRequired(value, AppLocalizations.of(context).reason),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isLoading ? null : _submitRequest,
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                  child: _isLoading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                        )
                      : Text(AppLocalizations.of(context).sendRequest),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
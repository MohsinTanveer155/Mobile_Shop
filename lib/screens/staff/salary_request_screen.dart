import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../providers/app_providers.dart';

class SalaryRequestScreen extends ConsumerStatefulWidget {
  const SalaryRequestScreen({super.key});

  @override
  ConsumerState<SalaryRequestScreen> createState() => _SalaryRequestScreenState();
}

class _SalaryRequestScreenState extends ConsumerState<SalaryRequestScreen> {
  final _amountController = TextEditingController();
  final _reasonController = TextEditingController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _amountController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _submitRequest() async {
    if (!_formKey.currentState!.validate()) return;
    final user = ref.read(authProvider);
    if (user == null) return;

    setState(() => _isLoading = true);
    try {
      await ref.read(salaryRequestNotifierProvider.notifier).sendRequest(
            uid: user.id,
            employeeName: user.name,
            amount: double.parse(_amountController.text.trim()),
            reason: _reasonController.text.trim(),
          );
      if (!mounted) return;
      _amountController.clear();
      _reasonController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Salary request submitted successfully.')),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Request failed: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider);
    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Salary Requests')),
        body: const Center(child: Text('Please sign in to view salary requests.')),
      );
    }

    final salaryRequests = ref.watch(mySalaryRequestsProvider(user.id));

    return Scaffold(
      appBar: AppBar(title: const Text('Salary Requests')),
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
                      const Text('New Salary Request', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _amountController,
                        decoration: const InputDecoration(labelText: 'Amount', prefixIcon: Icon(Icons.attach_money)),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Enter amount';
                          }
                          final parsed = double.tryParse(value.trim());
                          if (parsed == null || parsed <= 0) {
                            return 'Enter a valid amount';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _reasonController,
                        minLines: 3,
                        maxLines: 5,
                        decoration: const InputDecoration(labelText: 'Reason', prefixIcon: Icon(Icons.message)),
                        validator: (value) => value == null || value.trim().isEmpty ? 'Add a reason' : null,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _isLoading ? null : _submitRequest,
                        child: _isLoading
                            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                            : const Text('Send Request'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Request History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            salaryRequests.when(
              data: (requests) {
                if (requests.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: Text('No salary requests yet.')),
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: requests.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = requests[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(item.employeeName, style: const TextStyle(fontWeight: FontWeight.bold)),
                                Chip(
                                  label: Text(item.status.toString().split('.').last.toUpperCase()),
                                  backgroundColor: item.isApproved
                                      ? Colors.green.shade100
                                      : item.isRejected
                                          ? Colors.red.shade100
                                          : Colors.orange.shade100,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text('Amount: Rs ${item.amount.toStringAsFixed(0)}'),
                            const SizedBox(height: 6),
                            Text('Requested: ${DateFormat.yMMMd().format(item.requestDate)}'),
                            const SizedBox(height: 6),
                            Text('Reason: ${item.reason}'),
                            if (item.adminRemark != null) ...[
                              const SizedBox(height: 8),
                              Text('Admin Note: ${item.adminRemark}', style: const TextStyle(fontStyle: FontStyle.italic)),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('Error: $e'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../models/leave_request.dart';
import '../../providers/app_providers.dart';
import '../../widgets/role_guard.dart';

class AdminLeaveRequestsScreen extends ConsumerWidget {
  const AdminLeaveRequestsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RoleGuard(
      child: Scaffold(
        appBar: AppBar(title: const Text('Manage Leave Requests')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ref.watch(pendingLeavesProvider).when(
                data: (requests) {
                  if (requests.isEmpty) {
                    return const Center(child: Text('No pending leave requests.'));
                  }
                  return ListView.separated(
                    itemCount: requests.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final leave = requests[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(leave.staffName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                  Text(leave.type.name.toUpperCase()),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text('Period: ${DateFormat.yMMMd().format(leave.startDate)} - ${DateFormat.yMMMd().format(leave.endDate)}'),
                              const SizedBox(height: 6),
                              Text('Reason: ${leave.reason}'),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () => _showUpdateDialog(context, ref, leave, 'rejected'),
                                      style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
                                      child: const Text('Reject'),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () => _showUpdateDialog(context, ref, leave, 'approved'),
                                      child: const Text('Approve'),
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
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Text('Error: $e'),
              ),
        ),
      ),
    );
  }

  void _showUpdateDialog(BuildContext context, WidgetRef ref, LeaveRequest leave, String status) {
    final remarkController = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(status == 'approved' ? 'Approve Leave' : 'Reject Leave'),
        content: TextFormField(
          controller: remarkController,
          maxLines: 4,
          decoration: const InputDecoration(
            labelText: 'Admin remark',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await ref.read(leaveNotifierProvider.notifier).updateLeaveStatus(
                    leave.id,
                    status,
                    approvedByUid: ref.read(authProvider)?.id,
                    adminRemark: remarkController.text.trim().isEmpty ? null : remarkController.text.trim(),
                  );
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Leave ${status == 'approved' ? 'approved' : 'rejected'} successfully.')),
                );
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

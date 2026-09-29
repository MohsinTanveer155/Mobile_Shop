import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../config/colors.dart';
import '../../models/leave_request.dart';
import '../../providers/app_providers.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/status_badge.dart';

class LeaveScreen extends ConsumerStatefulWidget {
  final bool embedded;

  const LeaveScreen({super.key, this.embedded = false});

  @override
  ConsumerState<LeaveScreen> createState() => _LeaveScreenState();
}

class _LeaveScreenState extends ConsumerState<LeaveScreen> {
  final _formKey = GlobalKey<FormState>();
  final _reasonController = TextEditingController();
  LeaveType? _type;
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isLoading = false;

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _submitLeave() async {
    if (!_formKey.currentState!.validate() ||
        _type == null ||
        _startDate == null ||
        _endDate == null) {
      return;
    }
    if (_startDate!.isAfter(_endDate!)) return;

    setState(() => _isLoading = true);

    final user = ref.read(authProvider);
    if (user == null) {
      setState(() => _isLoading = false);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to submit leave: no authenticated user.'),
          ),
        );
      }
      return;
    }

    try {
      await ref.read(leaveNotifierProvider.notifier).applyLeave(
            uid: user.id,
            staffName: user.name,
            type: _type!.name,
            startDate: _startDate!,
            endDate: _endDate!,
            reason: _reasonController.text.trim(),
          );
    } catch (error) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Unable to submit leave: $error'),
            backgroundColor: AppColors.error,
          ),
        );
      }
      return;
    }

    if (!mounted) return;
    setState(() => _isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Leave request submitted.')),
    );
    _reasonController.clear();
    setState(() {
      _type = null;
      _startDate = null;
      _endDate = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider);
    if (user == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('Leave'),
          automaticallyImplyLeading: !widget.embedded,
        ),
        body: const Center(
          child: Text(
            'Please sign in to access leave management.',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ),
      );
    }

    final myLeaves = ref.watch(myLeavesProvider(user.id));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Leave'),
        automaticallyImplyLeading: !widget.embedded,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 0,
              color: AppColors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: AppColors.border),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Apply for Leave',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Submit a request for approval.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<LeaveType>(
                        initialValue: _type,
                        decoration: InputDecoration(
                          labelText: 'Leave Type',
                          filled: true,
                          fillColor: AppColors.surfaceAlt,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        items: LeaveType.values
                            .map(
                              (type) => DropdownMenuItem(
                                value: type,
                                child: Text(_leaveTypeLabel(type)),
                              ),
                            )
                            .toList(),
                        onChanged: (value) => setState(() => _type = value),
                        validator: (value) =>
                            value == null ? 'Select leave type' : null,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => _selectDate(true),
                              icon: const Icon(Icons.calendar_today_outlined, size: 18),
                              label: Text(
                                _startDate == null
                                    ? 'Start Date'
                                    : DateFormat('dd MMM yyyy').format(_startDate!),
                              ),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                foregroundColor: AppColors.textPrimary,
                                side: const BorderSide(color: AppColors.border),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => _selectDate(false),
                              icon: const Icon(Icons.event_outlined, size: 18),
                              label: Text(
                                _endDate == null
                                    ? 'End Date'
                                    : DateFormat('dd MMM yyyy').format(_endDate!),
                              ),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                foregroundColor: AppColors.textPrimary,
                                side: const BorderSide(color: AppColors.border),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (_startDate != null &&
                          _endDate != null &&
                          _startDate!.isAfter(_endDate!)) ...[
                        const SizedBox(height: 8),
                        const Text(
                          'End date must be after start date',
                          style: TextStyle(color: AppColors.error),
                        ),
                      ],
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _reasonController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Reason *',
                          alignLabelWithHint: true,
                          filled: true,
                          fillColor: AppColors.surfaceAlt,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) =>
                            value?.trim().isEmpty ?? true ? 'Reason required' : null,
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: FilledButton(
                          onPressed: _isLoading ? null : _submitLeave,
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.deepIndigo,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  'Submit Leave',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'My Leave Requests',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
            ),
            const SizedBox(height: 12),
            myLeaves.when(
              data: (leaves) {
                if (leaves.isEmpty) {
                  return const EmptyState(
                    icon: Icons.event_available_outlined,
                    title: 'No leave requests',
                    subtitle: 'Your leave applications will show up here.',
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: leaves.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final leave = leaves[index];
                    return _LeaveRequestCard(leave: leave);
                  },
                );
              },
              loading: () => const SizedBox(
                height: 100,
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (_, __) => const Text(
                'Unable to load leave requests. Please try again.',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  String _leaveTypeLabel(LeaveType type) {
    final name = type.name;
    return '${name[0].toUpperCase()}${name.substring(1)}';
  }
}

class _LeaveRequestCard extends StatelessWidget {
  final LeaveRequest leave;

  const _LeaveRequestCard({required this.leave});

  @override
  Widget build(BuildContext context) {
    final typeLabel =
        '${leave.type.name[0].toUpperCase()}${leave.type.name.substring(1)}';
    final range =
        '${DateFormat('dd MMM').format(leave.startDate)} – ${DateFormat('dd MMM').format(leave.endDate)}';

    return Card(
      elevation: 0,
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '$typeLabel Leave',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                  ),
                ),
                _leaveStatusBadge(leave),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '$range · ${leave.totalDays} day${leave.totalDays == 1 ? '' : 's'}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            if (leave.reason.trim().isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                leave.reason,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textPrimary,
                    ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

Widget _leaveStatusBadge(LeaveRequest leave) {
  if (leave.isApproved) {
    return StatusBadge.approved(label: 'Approved');
  }
  if (leave.isRejected) {
    return StatusBadge.rejected(label: 'Rejected');
  }
  return StatusBadge.pending(label: 'Pending');
}

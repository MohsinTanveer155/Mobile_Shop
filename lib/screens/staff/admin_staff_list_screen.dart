import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/colors.dart';
import '../../models/user.dart';
import '../../providers/app_providers.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/staff_card.dart';

class AdminStaffListScreen extends ConsumerStatefulWidget {
  final bool embedded;

  const AdminStaffListScreen({super.key, this.embedded = false});

  @override
  ConsumerState<AdminStaffListScreen> createState() =>
      _AdminStaffListScreenState();
}

class _AdminStaffListScreenState extends ConsumerState<AdminStaffListScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final staffList = ref.watch(allStaffProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Staff'),
        automaticallyImplyLeading: !widget.embedded,
        actions: [
          IconButton(
            tooltip: 'Add staff',
            icon: const Icon(Icons.person_add_alt_1_outlined),
            onPressed: () => _showAddStaffDialog(context, ref),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _query = value.trim()),
              decoration: InputDecoration(
                hintText: 'Search staff by name or phone',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
          ),
          Expanded(
            child: staffList.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(
                    'Unable to load staff list. Please try again.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ),
              ),
              data: (staff) {
                final filtered = _filterStaff(staff, _query);
                if (filtered.isEmpty) {
                  return EmptyState(
                    icon: Icons.groups_outlined,
                    title: _query.isEmpty ? 'No staff yet' : 'No matches',
                    subtitle: _query.isEmpty
                        ? 'Add team members to manage them here.'
                        : 'Try a different name or phone number.',
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final user = filtered[index];
                    return StaffCard(
                      staff: user,
                      onSalaryTap: () => _showSalaryDialog(context, ref, user),
                      onProfileTap: () =>
                          _showEditStaffDialog(context, ref, user),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddStaffDialog(context, ref),
        icon: const Icon(Icons.person_add_alt_1),
        label: const Text('Add Staff'),
        backgroundColor: AppColors.deepIndigo,
        foregroundColor: Colors.white,
      ),
    );
  }

  List<User> _filterStaff(List<User> staff, String query) {
    if (query.isEmpty) return staff;
    final q = query.toLowerCase();
    return staff.where((u) {
      final name = u.name.toLowerCase();
      final phone = (u.phone ?? '').toLowerCase();
      final email = (u.email ?? '').toLowerCase();
      return name.contains(q) || phone.contains(q) || email.contains(q);
    }).toList();
  }

  void _showAddStaffDialog(BuildContext context, WidgetRef ref) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Use Signup screen for new staff')),
    );
  }

  void _showEditStaffDialog(BuildContext context, WidgetRef ref, User user) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Edit profile coming soon')),
    );
  }

  void _showSalaryDialog(BuildContext context, WidgetRef ref, User user) {
    final controller =
        TextEditingController(text: user.salary?.toString() ?? '');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Update ${user.name}'s Salary"),
        content: TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Monthly Salary',
            filled: true,
            fillColor: AppColors.surfaceAlt,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final salary = double.tryParse(controller.text);
              if (salary != null) {
                ref.read(staffNotifierProvider.notifier).updateProfile(
                  user.id,
                  {'salary': salary},
                );
              }
              Navigator.pop(context);
            },
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.deepIndigo,
              foregroundColor: Colors.white,
            ),
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}

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

  Future<void> _showAddStaffDialog(BuildContext context, WidgetRef ref) async {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();
    final salaryController = TextEditingController();
    final messenger = ScaffoldMessenger.maybeOf(context);

    try {
      final values = await showDialog<Map<String, String?>>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Add Employee'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(labelText: 'Full name'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: 'Phone'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Temporary password',
                    helperText: 'At least 6 characters',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: salaryController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: 'Monthly salary'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, {
                'name': nameController.text.trim(),
                'email': emailController.text.trim(),
                'phone': phoneController.text.trim(),
                'password': passwordController.text,
                'salary': salaryController.text.trim(),
              }),
              child: const Text('Create'),
            ),
          ],
        ),
      );

      if (!mounted) return;
      if (values == null) return;
      final name = values['name'] ?? '';
      final email = values['email'] ?? '';
      final password = values['password'] ?? '';
      final salaryText = values['salary'] ?? '';
      if (name.isEmpty || !email.contains('@') || password.length < 6) {
        messenger?.showSnackBar(
          SnackBar(
            content: const Text('Enter a valid name, email, and password.'),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }
      final salary = salaryText.isEmpty ? null : double.tryParse(salaryText);
      if (salaryText.isNotEmpty && salary == null) {
        messenger?.showSnackBar(
          SnackBar(
            content: const Text('Enter a valid salary amount.'),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }

      await ref.read(staffProvider.notifier).createStaff(
        name: name,
        email: email,
        password: password,
        phone: values['phone'],
        salary: salary,
      );

      if (!mounted) return;
      ref.invalidate(allStaffProvider);
      messenger?.showSnackBar(
        SnackBar(
          content: const Text('Employee added successfully.'),
          backgroundColor: AppColors.success,
        ),
      );
    } catch (error) {
      if (mounted) {
        messenger?.showSnackBar(
          SnackBar(
            content: Text('Unable to add employee: $error'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      nameController.dispose();
      emailController.dispose();
      phoneController.dispose();
      passwordController.dispose();
      salaryController.dispose();
    }
  }

  Future<void> _showEditStaffDialog(
    BuildContext context,
    WidgetRef ref,
    User user,
  ) async {
    final nameController = TextEditingController(text: user.name);
    final phoneController = TextEditingController(text: user.phone ?? '');
    final salaryController = TextEditingController(
      text: user.salary?.toStringAsFixed(0) ?? '',
    );
    final messenger = ScaffoldMessenger.maybeOf(context);

    try {
      final values = await showDialog<Map<String, String?>>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text('Edit ${user.name}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Full name'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: 'Phone'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: salaryController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: 'Monthly salary'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, {'delete': 'true'}),
              child: const Text('Delete', style: TextStyle(color: AppColors.error)),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, {
                'name': nameController.text.trim(),
                'phone': phoneController.text.trim(),
                'salary': salaryController.text.trim(),
              }),
              child: const Text('Save'),
            ),
          ],
        ),
      );

      if (values == null) return;
      if (values['delete'] == 'true') {
        await _deleteStaff(ref, user);
        return;
      }
      final name = values['name'] ?? '';
      final salaryText = values['salary'] ?? '';
      final salary = salaryText.isEmpty ? null : double.tryParse(salaryText);
      if (name.isEmpty || (salaryText.isNotEmpty && salary == null)) {
        messenger?.showSnackBar(
          SnackBar(
            content: const Text('Enter valid employee details.'),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }
      await ref.read(staffProvider.notifier).updateProfile(user.id, {
        'name': name,
        'phone': values['phone'],
        'salary': salary,
      });
      ref.invalidate(allStaffProvider);
      messenger?.showSnackBar(
        SnackBar(
          content: const Text('Employee updated successfully.'),
          backgroundColor: AppColors.success,
        ),
      );
    } catch (error) {
      messenger?.showSnackBar(
        SnackBar(
          content: Text('Unable to update employee: $error'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      nameController.dispose();
      phoneController.dispose();
      salaryController.dispose();
    }
  }

  Future<void> _deleteStaff(WidgetRef ref, User user) async {
    final messenger = ScaffoldMessenger.maybeOf(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete employee?'),
        content: Text('Remove ${user.name} from the staff list?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: FilledButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    try {
      await ref.read(staffProvider.notifier).deleteProfile(user.id);
      ref.invalidate(allStaffProvider);
      messenger?.showSnackBar(
        SnackBar(
          content: const Text('Employee removed from the staff list.'),
          backgroundColor: AppColors.success,
        ),
      );
    } catch (error) {
      messenger?.showSnackBar(
        SnackBar(
          content: Text('Unable to delete employee: $error'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  void _showSalaryDialog(BuildContext context, WidgetRef ref, User user) {
    final controller = TextEditingController(text: user.salary?.toString() ?? '');
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
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
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              final dialogNavigator = Navigator.of(dialogContext);
              final dialogMessenger = ScaffoldMessenger.maybeOf(dialogContext);
              final salaryText = controller.text.trim();
              final salary = double.tryParse(salaryText);
              if (salary == null && salaryText.isNotEmpty) {
                dialogMessenger?.showSnackBar(
                  const SnackBar(content: Text('Enter a valid salary amount.')),
                );
                return;
              }

              try {
                await ref.read(staffProvider.notifier).updateProfile(
                  user.id,
                  {'salary': salary},
                );
                if (!mounted) return;
                ref.invalidate(allStaffProvider);
                if (dialogNavigator.canPop()) {
                  dialogNavigator.pop();
                }
              } catch (error) {
                if (!mounted) return;
                dialogMessenger?.showSnackBar(
                  SnackBar(content: Text('Unable to update salary: $error')),
                );
              } finally {
                controller.dispose();
              }
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

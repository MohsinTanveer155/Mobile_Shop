import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/app_providers.dart';
import '../../widgets/role_guard.dart';
import 'admin_staff_list_screen.dart';
import 'admin_leave_requests_screen.dart';
import 'admin_salary_requests_screen.dart';
import 'salary_screen.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RoleGuard(
      child: Scaffold(
        appBar: AppBar(title: const Text('HR Dashboard')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Executive HR Overview', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              _buildSummaryGrid(context, ref),
              const SizedBox(height: 24),
              const Text('Quick Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _buildActionTiles(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryGrid(BuildContext context, WidgetRef ref) {
    final staffCount = ref.watch(allStaffProvider);
    final pendingLeaveCount = ref.watch(pendingLeavesProvider);
    final pendingSalaryCount = ref.watch(pendingSalaryRequestsProvider);

    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _summaryCard(
                  title: 'Employees',
                  value: staffCount.when(
                    data: (list) => list.length.toString(),
                    loading: () => 'Loading',
                    error: (_, __) => 'Error',
                  ),
                  color: Colors.indigo,
                ),
                _summaryCard(
                  title: 'Pending Leave',
                  value: pendingLeaveCount.when(
                    data: (list) => list.length.toString(),
                    loading: () => 'Loading',
                    error: (_, __) => 'Error',
                  ),
                  color: Colors.orange,
                ),
                _summaryCard(
                  title: 'Salary Requests',
                  value: pendingSalaryCount.when(
                    data: (list) => list.length.toString(),
                    loading: () => 'Loading',
                    error: (_, __) => 'Error',
                  ),
                  color: Colors.green,
                ),
                _summaryCard(
                  title: 'Active Admin',
                  value: '1',
                  color: Colors.teal,
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildActionTiles(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _ActionTile(label: 'Manage Staff', icon: Icons.people, onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminStaffListScreen()));
        }),
        _ActionTile(label: 'Leave Requests', icon: Icons.beach_access, onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminLeaveRequestsScreen()));
        }),
        _ActionTile(label: 'Salary Requests', icon: Icons.payments, onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminSalaryRequestsScreen()));
        }),
        _ActionTile(label: 'Generate Payroll', icon: Icons.calculate, onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const SalaryScreen()));
        }),
      ],
    );
  }

  Widget _summaryCard({required String title, required String value, required Color color}) {
    return SizedBox(
      width: 180,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 14),
              Text(value, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: color)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _ActionTile({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 13),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.indigo, size: 32),
            const SizedBox(height: 12),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

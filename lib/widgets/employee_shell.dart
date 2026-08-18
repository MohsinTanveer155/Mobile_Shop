import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../screens/staff/attendance_screen.dart';
import '../screens/staff/leave_screen.dart';
import '../screens/staff/salary_screen.dart';
import '../screens/staff/staff_dashboard_screen.dart';
import '../screens/staff/staff_profile_screen.dart';

/// Employee root shell: Home · Attendance · Leave · Salary · Profile
class EmployeeShell extends ConsumerStatefulWidget {
  final int initialIndex;

  const EmployeeShell({super.key, this.initialIndex = 0});

  @override
  ConsumerState<EmployeeShell> createState() => _EmployeeShellState();
}

class _EmployeeShellState extends ConsumerState<EmployeeShell> {
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const StaffDashboardScreen(embedded: true),
      const AttendanceScreen(embedded: true),
      const LeaveScreen(embedded: true),
      const SalaryScreen(embedded: true),
      const StaffProfileScreen(embedded: true),
    ];

    return Scaffold(
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.access_time_outlined),
            selectedIcon: Icon(Icons.access_time),
            label: 'Attendance',
          ),
          NavigationDestination(
            icon: Icon(Icons.event_busy_outlined),
            selectedIcon: Icon(Icons.event_busy),
            label: 'Leave',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: Icon(Icons.account_balance_wallet),
            label: 'Salary',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

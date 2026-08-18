import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/colors.dart';
import '../providers/auth_provider.dart';
import '../screens/bundle_list_screen.dart';
import '../screens/customer_list_screen.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/product_list_screen.dart';
import '../screens/reports_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/staff/admin_staff_list_screen.dart';
import '../screens/warranty_list_screen.dart';

/// Admin root shell: Dashboard · Products · Orders · Staff · More
class AdminShell extends ConsumerStatefulWidget {
  final int initialIndex;

  const AdminShell({super.key, this.initialIndex = 0});

  @override
  ConsumerState<AdminShell> createState() => _AdminShellState();
}

class _AdminShellState extends ConsumerState<AdminShell> {
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 900;

    final pages = <Widget>[
      const HomeScreen(embedded: true),
      const ProductListScreen(embedded: true),
      const OrdersScreen(embedded: true),
      const AdminStaffListScreen(embedded: true),
      const _AdminMorePage(),
    ];

    if (isWide) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: _index,
              onDestinationSelected: (i) => setState(() => _index = i),
              extended: MediaQuery.of(context).size.width >= 1100,
              backgroundColor: AppColors.surface,
              indicatorColor: AppColors.deepIndigo.withValues(alpha: 0.12),
              selectedIconTheme: const IconThemeData(color: AppColors.deepIndigo),
              selectedLabelTextStyle: const TextStyle(
                color: AppColors.deepIndigo,
                fontWeight: FontWeight.w600,
              ),
              leading: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.deepIndigo,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.storefront, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Mobile Shop',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                    ),
                  ],
                ),
              ),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.dashboard_outlined),
                  selectedIcon: Icon(Icons.dashboard),
                  label: Text('Dashboard'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.phone_android_outlined),
                  selectedIcon: Icon(Icons.phone_android),
                  label: Text('Products'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.shopping_cart_outlined),
                  selectedIcon: Icon(Icons.shopping_cart),
                  label: Text('Orders'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.people_outline),
                  selectedIcon: Icon(Icons.people),
                  label: Text('Staff'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.more_horiz),
                  selectedIcon: Icon(Icons.more_horiz),
                  label: Text('More'),
                ),
              ],
            ),
            const VerticalDivider(width: 1),
            Expanded(child: pages[_index]),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: _index == 4
          ? AppBar(title: const Text('More'))
          : null,
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.phone_android_outlined),
            selectedIcon: Icon(Icons.phone_android),
            label: 'Products',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart_outlined),
            selectedIcon: Icon(Icons.shopping_cart),
            label: 'Orders',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Staff',
          ),
          NavigationDestination(
            icon: Icon(Icons.more_horiz),
            selectedIcon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
      ),
    );
  }
}

class _AdminMorePage extends ConsumerWidget {
  const _AdminMorePage();

  Future<void> _logout(WidgetRef ref, BuildContext context) async {
    await ref.read(authProvider.notifier).logout();
    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (_) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = <_MoreItem>[
      _MoreItem(Icons.verified_outlined, 'Warranty', () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const WarrantyListScreen()));
      }),
      _MoreItem(Icons.inventory_2_outlined, 'Bundles', () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const BundleListScreen()));
      }),
      _MoreItem(Icons.analytics_outlined, 'Reports', () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const ReportsScreen()));
      }),
      _MoreItem(Icons.people_outline, 'Customers', () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomerListScreen()));
      }),
      _MoreItem(Icons.settings_outlined, 'Settings', () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
      }),
    ];

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Shop Tools', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            'Warranty, bundles, reports, and account settings',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          ...items.map(
            (item) => Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.deepIndigo.withValues(alpha: 0.1),
                  child: Icon(item.icon, color: AppColors.deepIndigo),
                ),
                title: Text(item.label, style: const TextStyle(fontWeight: FontWeight.w600)),
                trailing: const Icon(Icons.chevron_right),
                onTap: item.onTap,
              ),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => _logout(ref, context),
            icon: const Icon(Icons.logout, color: AppColors.error),
            label: const Text('Logout', style: TextStyle(color: AppColors.error)),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.error),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ],
      ),
    );
  }
}

class _MoreItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  _MoreItem(this.icon, this.label, this.onTap);
}

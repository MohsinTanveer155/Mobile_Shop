import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../providers/theme_provider.dart';
import '../screens/customer_list_screen.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/notification_settings_screen.dart';
import '../screens/product_list_screen.dart';
import '../screens/reports_screen.dart';
import '../screens/sales_screen.dart';

/// Responsive scaffold with sidebar for desktop/tablet and drawer for mobile.
/// Provides consistent navigation, app bar, and theme toggle across screens.
class ResponsiveScaffold extends ConsumerWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final int selectedIndex;
  final bool showNav;

  const ResponsiveScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.floatingActionButton,
    this.selectedIndex = 0,
    this.showNav = true,
  });

  static const double _sidebarWidth = 260;
  static const double _breakpoint = 800;

  void _navigateTo(BuildContext context, int index) {
    if (index == selectedIndex) return;

    Widget screen;
    switch (index) {
      case 0:
        screen = const HomeScreen();
        break;
      case 1:
        screen = const SalesScreen();
        break;
      case 2:
        screen = const ProductListScreen();
        break;
      case 3:
        screen = const CustomerListScreen();
        break;
      case 4:
        screen = const ReportsScreen();
        break;
      case 5:
        screen = const NotificationSettingsScreen();
        break;
      default:
        screen = const HomeScreen();
    }

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  Future<void> _logout(WidgetRef ref, BuildContext context) async {
    await ref.read(authProvider.notifier).logout();
    if (context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    final isAdmin = user?.isAdmin ?? false;
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth >= _breakpoint;

    final navItems = _buildNavItems(isAdmin);

    return Scaffold(
      appBar: isWide
          ? null
          : AppBar(
              title: Text(title),
              centerTitle: true,
              actions: [
                ...?actions,
                _ThemeToggleButton(isDark: isDark),
                const SizedBox(width: 8),
              ],
            ),
      drawer: isWide || !showNav
          ? null
          : _buildDrawer(context, ref, navItems, isDark, isAdmin),
      body: Row(
        children: [
          if (isWide && showNav)
            _buildSidebar(context, ref, navItems, isDark, isAdmin),
          Expanded(child: body),
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }

  List<_NavItem> _buildNavItems(bool isAdmin) {
    final items = <_NavItem>[
      _NavItem(Icons.dashboard_outlined, Icons.dashboard, 'Dashboard', 0),
      _NavItem(Icons.point_of_sale_outlined, Icons.point_of_sale, 'Sales', 1),
    ];
    if (isAdmin) {
      items.addAll([
        _NavItem(Icons.inventory_2_outlined, Icons.inventory_2, 'Products', 2),
        _NavItem(Icons.people_outline, Icons.people, 'Customers', 3),
        _NavItem(Icons.bar_chart_outlined, Icons.bar_chart, 'Reports', 4),
        _NavItem(Icons.settings_outlined, Icons.settings, 'Settings', 5),
      ]);
    }
    return items;
  }

  Widget _buildSidebar(
    BuildContext context,
    WidgetRef ref,
    List<_NavItem> items,
    bool isDark,
    bool isAdmin,
  ) {
    return Container(
      width: _sidebarWidth,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E2E) : Colors.white,
        border: Border(
          right: BorderSide(
            color: isDark ? Colors.white12 : Colors.grey.shade200,
          ),
        ),
      ),
      child: Column(
        children: [
          _buildSidebarHeader(context, isDark),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final isSelected = item.index == selectedIndex;
                return _SidebarTile(
                  item: item,
                  isSelected: isSelected,
                  isDark: isDark,
                  onTap: () => _navigateTo(context, item.index),
                );
              },
            ),
          ),
          const Divider(height: 1),
          _buildSidebarFooter(context, ref, isDark, isAdmin),
        ],
      ),
    );
  }

  Widget _buildSidebarHeader(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.store, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mobile Shop',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'POS System',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.white60 : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarFooter(
    BuildContext context,
    WidgetRef ref,
    bool isDark,
    bool isAdmin,
  ) {
    final user = ref.watch(authProvider);
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          _ThemeToggleButton(isDark: isDark),
          const SizedBox(height: 8),
          ListTile(
            leading: CircleAvatar(
              radius: 16,
              backgroundColor: isAdmin ? Colors.indigo : Colors.teal,
              child: Icon(
                isAdmin ? Icons.admin_panel_settings : Icons.person,
                size: 18,
                color: Colors.white,
              ),
            ),
            title: Text(
              user?.name ?? 'User',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              isAdmin ? 'Administrator' : 'Employee',
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.white60 : Colors.grey.shade600,
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.logout, size: 20, color: isDark ? Colors.white70 : Colors.grey.shade700),
              onPressed: () => _logout(ref, context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(
    BuildContext context,
    WidgetRef ref,
    List<_NavItem> items,
    bool isDark,
    bool isAdmin,
  ) {
    final user = ref.watch(authProvider);
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: isAdmin ? Colors.white : Colors.teal.shade100,
              child: Icon(
                isAdmin ? Icons.admin_panel_settings : Icons.person,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            accountName: Text(user?.name ?? 'User'),
            accountEmail: Text(isAdmin ? 'Administrator' : 'Store Employee'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final isSelected = item.index == selectedIndex;
                return ListTile(
                  leading: Icon(
                    isSelected ? item.selectedIcon : item.icon,
                    color: isSelected ? Theme.of(context).colorScheme.primary : null,
                  ),
                  title: Text(
                    item.label,
                    style: TextStyle(
                      color: isSelected ? Theme.of(context).colorScheme.primary : null,
                      fontWeight: isSelected ? FontWeight.w600 : null,
                    ),
                  ),
                  selected: isSelected,
                  onTap: () {
                    Navigator.pop(context);
                    _navigateTo(context, item.index);
                  },
                );
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () => _logout(ref, context),
          ),
        ],
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final int index;

  _NavItem(this.icon, this.selectedIcon, this.label, this.index);
}

class _SidebarTile extends StatelessWidget {
  final _NavItem item;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onTap;

  const _SidebarTile({
    required this.item,
    required this.isSelected,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? primary.withValues(alpha: 0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(
                isSelected ? item.selectedIcon : item.icon,
                size: 22,
                color: isSelected ? primary : (isDark ? Colors.white60 : Colors.grey.shade600),
              ),
              const SizedBox(width: 14),
              Text(
                item.label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected
                      ? primary
                      : (isDark ? Colors.white70 : Colors.grey.shade800),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ThemeToggleButton extends ConsumerWidget {
  final bool isDark;

  const _ThemeToggleButton({required this.isDark});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
      tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
      onPressed: () => ref.read(themeProvider.notifier).toggleTheme(),
    );
  }
}


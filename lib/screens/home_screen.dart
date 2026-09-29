import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../config/colors.dart';
import '../models/sale.dart';
import '../models/user.dart';
import '../providers/app_providers.dart';
import '../services/pos_service.dart';
import '../widgets/app_card.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/empty_state.dart';
import '../widgets/loading_state.dart';
import '../widgets/status_badge.dart';
import 'orders_screen.dart';
// NOTE: Added — ProductListScreen was used below but never imported,
// which caused "creation_with_non_type" / undefined class errors.
// Update this path if your product list screen lives elsewhere.
import 'product_list_screen.dart';
import 'staff/admin_leave_requests_screen.dart';
import 'staff/admin_salary_requests_screen.dart';
import 'staff/admin_staff_list_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  /// When true, used inside [AdminShell] without its own nav scaffold.
  final bool embedded;

  const HomeScreen({super.key, this.embedded = false});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

enum _SalesPeriod { daily, weekly, monthly }

class _HomeScreenState extends ConsumerState<HomeScreen> {
  _SalesPeriod _period = _SalesPeriod.daily;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _initializeNotifications(),
    );
  }

  Future<void> _initializeNotifications() async {
    final notificationService = ref.read(notificationServiceProvider);
    final posServiceAsync = ref.read(posServiceProvider);
    await notificationService.initialize();
    final granted = await notificationService.requestPermissions();
    if (granted) {
      posServiceAsync.whenData((service) async {
        await notificationService.showDailyReminderIfNeeded(service);
        await notificationService.checkLowStock(service.products);
      });
    }
  }

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  double _salesForPeriod(PosService service) {
    final now = DateTime.now();
    switch (_period) {
      case _SalesPeriod.daily:
        return service.sales
            .where(
              (s) =>
                  s.date.year == now.year &&
                  s.date.month == now.month &&
                  s.date.day == now.day,
            )
            .fold(0.0, (sum, s) => sum + s.totalPrice);
      case _SalesPeriod.weekly:
        final start = now.subtract(Duration(days: now.weekday - 1));
        final dayStart = DateTime(start.year, start.month, start.day);
        return service.sales
            .where((s) => !s.date.isBefore(dayStart))
            .fold(0.0, (sum, s) => sum + s.totalPrice);
      case _SalesPeriod.monthly:
        return service.sales
            .where((s) => s.date.year == now.year && s.date.month == now.month)
            .fold(0.0, (sum, s) => sum + s.totalPrice);
    }
  }

  List<FlSpot> _chartSpots(PosService service) {
    final now = DateTime.now();
    switch (_period) {
      case _SalesPeriod.daily:
        final spots = <FlSpot>[];
        for (var h = 0; h < 24; h += 3) {
          final total = service.sales
              .where(
                (s) =>
                    s.date.year == now.year &&
                    s.date.month == now.month &&
                    s.date.day == now.day &&
                    s.date.hour >= h &&
                    s.date.hour < h + 3,
              )
              .fold(0.0, (sum, s) => sum + s.totalPrice);
          spots.add(FlSpot(h.toDouble(), total));
        }
        return spots;
      case _SalesPeriod.weekly:
        return List.generate(7, (i) {
          final day = now.subtract(Duration(days: 6 - i));
          final total = service.sales
              .where(
                (s) =>
                    s.date.year == day.year &&
                    s.date.month == day.month &&
                    s.date.day == day.day,
              )
              .fold(0.0, (sum, s) => sum + s.totalPrice);
          return FlSpot(i.toDouble(), total);
        });
      case _SalesPeriod.monthly:
        final days = DateTime(now.year, now.month + 1, 0).day;
        final step = (days / 6).ceil();
        return List.generate(7, (i) {
          final startDay = (i * step) + 1;
          final endDay = (startDay + step - 1).clamp(1, days);
          final total = service.sales
              .where(
                (s) =>
                    s.date.year == now.year &&
                    s.date.month == now.month &&
                    s.date.day >= startDay &&
                    s.date.day <= endDay,
              )
              .fold(0.0, (sum, s) => sum + s.totalPrice);
          return FlSpot(i.toDouble(), total);
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    final serviceAsync = ref.watch(posServiceProvider);
    final user = ref.watch(authProvider);
    final staffAsync = ref.watch(allStaffProvider);
    final pendingLeaves = ref.watch(pendingLeavesProvider);
    final pendingSalary = ref.watch(adminSalaryRequestsProvider);

    final body = serviceAsync.when(
      loading: () => const LoadingState(message: 'Loading dashboard...'),
      error: (err, _) => EmptyState(
        icon: Icons.error_outline,
        title: 'Unable to Load Dashboard',
        subtitle: 'Unable to load this information. Please try again.',
        onActionPressed: () => ref.refresh(posServiceProvider),
        actionLabel: 'Retry',
        iconColor: AppColors.error,
      ),
      data: (service) {
        final staffCount = staffAsync.maybeWhen(
          data: (list) => list.where((u) => !u.isAdmin).length,
          orElse: () => 0,
        );
        final todaySales = service.sales.where((s) {
          final n = DateTime.now();
          return s.date.year == n.year &&
              s.date.month == n.month &&
              s.date.day == n.day;
        }).length;
        final lowStock = service.products
            .where((p) => p.quantity <= 5)
            .toList();
        final recent = (List<Sale>.from(
          service.sales,
        )..sort(Sale.byDateDesc)).take(5).toList();
        final leaveCount = pendingLeaves.maybeWhen(
          data: (l) => l.length,
          orElse: () => 0,
        );
        final salaryCount = pendingSalary.maybeWhen(
          data: (l) => l.length,
          orElse: () => 0,
        );

        return RefreshIndicator(
          onRefresh: () async => ref.refresh(posServiceProvider),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _WelcomeHeader(greeting: _greeting(), user: user),
                const SizedBox(height: 20),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final cross = constraints.maxWidth > 700 ? 4 : 2;
                    return GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: cross,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: constraints.maxWidth > 700
                          ? 1.45
                          : 1.12,
                      children: [
                        DashboardStatCard(
                          title: 'Products',
                          value: '${service.totalProducts}',
                          icon: Icons.phone_android,
                          iconColor: AppColors.indigoBlue,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ProductListScreen(),
                            ),
                          ),
                        ),
                        DashboardStatCard(
                          title: 'Staff',
                          value: '$staffCount',
                          icon: Icons.people,
                          iconColor: AppColors.purple,
                          subtitle: 'Active members',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AdminStaffListScreen(),
                            ),
                          ),
                        ),
                        DashboardStatCard(
                          title: 'Sales',
                          value:
                              'Rs ${_salesForPeriod(service).toStringAsFixed(0)}',
                          icon: Icons.trending_up,
                          iconColor: AppColors.success,
                          subtitle: _period.name,
                        ),
                        DashboardStatCard(
                          title: 'Orders',
                          value: '$todaySales',
                          icon: Icons.shopping_cart,
                          iconColor: AppColors.warning,
                          subtitle: "Today's orders",
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const OrdersScreen(),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 24),
                SectionHeader(
                  title: 'Sales Overview',
                  trailing: SegmentedButton<_SalesPeriod>(
                    segments: const [
                      ButtonSegment(
                        value: _SalesPeriod.daily,
                        label: Text('D'),
                      ),
                      ButtonSegment(
                        value: _SalesPeriod.weekly,
                        label: Text('W'),
                      ),
                      ButtonSegment(
                        value: _SalesPeriod.monthly,
                        label: Text('M'),
                      ),
                    ],
                    selected: {_period},
                    onSelectionChanged: (s) =>
                        setState(() => _period = s.first),
                    style: const ButtonStyle(
                      visualDensity: VisualDensity.compact,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                AppCard(
                  child: SizedBox(
                    height: 200,
                    child: _SalesChart(spots: _chartSpots(service)),
                  ),
                ),
                const SizedBox(height: 24),
                SectionHeader(
                  title: 'Recent Orders',
                  trailing: TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const OrdersScreen()),
                    ),
                    child: const Text('View All'),
                  ),
                ),
                const SizedBox(height: 8),
                if (recent.isEmpty)
                  const AppCard(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('No recent orders yet.'),
                    ),
                  )
                else
                  ...recent.map((sale) => _RecentOrderTile(sale: sale)),
                const SizedBox(height: 24),
                const SectionHeader(title: 'Low Stock Products'),
                const SizedBox(height: 8),
                if (lowStock.isEmpty)
                  const AppCard(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('All products are sufficiently stocked.'),
                    ),
                  )
                else
                  ...lowStock
                      .take(5)
                      .map(
                        (p) => Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: AppColors.warning.withValues(
                                alpha: 0.15,
                              ),
                              child: const Icon(
                                Icons.inventory_2,
                                color: AppColors.warning,
                              ),
                            ),
                            title: Text(
                              p.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(p.brand ?? 'Product'),
                            trailing: StatusBadge.warning(
                              label: '${p.quantity} left',
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 24),
                const SectionHeader(title: 'Pending Requests'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: AppCard(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AdminLeaveRequestsScreen(),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.event_busy,
                              color: AppColors.indigoBlue,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '$leaveCount',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const Text('Leave requests'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppCard(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AdminSalaryRequestsScreen(),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.account_balance_wallet,
                              color: AppColors.success,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '$salaryCount',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const Text('Salary requests'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );

    if (widget.embedded) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          automaticallyImplyLeading: false,
        ),
        body: body,
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: body,
    );
  }
}

class _WelcomeHeader extends StatelessWidget {
  final String greeting;
  final User? user;

  const _WelcomeHeader({required this.greeting, required this.user});

  @override
  Widget build(BuildContext context) {
    final name = user?.name.split(' ').first ?? 'Admin';
    final isAdmin = user?.isAdmin ?? false;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.gradientStart, AppColors.gradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$greeting, $name 👋',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Here's your shop overview",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          CircleAvatar(
            radius: 26,
            backgroundColor: Colors.white24,
            child: Icon(
              isAdmin ? Icons.admin_panel_settings : Icons.person,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _SalesChart extends StatelessWidget {
  final List<FlSpot> spots;

  const _SalesChart({required this.spots});

  @override
  Widget build(BuildContext context) {
    final maxY = spots.fold<double>(0, (m, s) => s.y > m ? s.y : m);
    return LineChart(
      LineChartData(
        minY: 0,
        maxY: maxY <= 0 ? 100 : maxY * 1.2,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (v) => FlLine(
            color: AppColors.border.withValues(alpha: 0.8),
            strokeWidth: 1,
          ),
        ),
        titlesData: const FlTitlesData(
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots.isEmpty ? [const FlSpot(0, 0)] : spots,
            isCurved: true,
            color: AppColors.deepIndigo,
            barWidth: 3,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: AppColors.deepIndigo.withValues(alpha: 0.12),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentOrderTile extends StatelessWidget {
  final Sale sale;

  const _RecentOrderTile({required this.sale});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.deepIndigo.withValues(alpha: 0.1),
          child: const Icon(
            Icons.shopping_bag,
            color: AppColors.deepIndigo,
            size: 20,
          ),
        ),
        title: Text(
          sale.productName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          '${DateFormat('dd MMM').format(sale.date)} · ${sale.payment.methodName}',
        ),
        trailing: Text(
          'Rs ${sale.totalPrice.toStringAsFixed(0)}',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.deepIndigo,
          ),
        ),
      ),
    );
  }
}

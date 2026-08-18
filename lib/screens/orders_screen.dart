import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../config/colors.dart';
import '../models/sale.dart';
import '../providers/app_providers.dart';
import '../widgets/empty_state.dart';
import '../widgets/loading_state.dart';
import '../widgets/order_card.dart';
import '../widgets/role_guard.dart';
import 'sales_screen.dart';

/// Orders list backed by existing Sale records (POS transactions).
class OrdersScreen extends ConsumerStatefulWidget {
  final bool embedded;

  const OrdersScreen({super.key, this.embedded = false});

  @override
  ConsumerState<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _search = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Sale> _filter(List<Sale> sales, int tab) {
    var list = List<Sale>.from(sales)..sort(Sale.byDateDesc);
    if (_search.isNotEmpty) {
      final q = _search.toLowerCase();
      list = list
          .where((s) =>
              s.productName.toLowerCase().contains(q) ||
              s.payment.methodName.toLowerCase().contains(q) ||
              (s.customerId?.toLowerCase().contains(q) ?? false))
          .toList();
    }
    final now = DateTime.now();
    switch (tab) {
      case 1: // Today
        return list
            .where((s) =>
                s.date.year == now.year &&
                s.date.month == now.month &&
                s.date.day == now.day)
            .toList();
      case 2: // Credit / pending payment portion
        return list.where((s) => s.creditAmount > 0).toList();
      default:
        return list;
    }
  }

  void _showDetails(BuildContext context, Sale sale) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text('Order Details', style: Theme.of(ctx).textTheme.headlineSmall),
              const SizedBox(height: 16),
              _DetailRow('Product', sale.productName),
              _DetailRow('Quantity', '${sale.quantity}'),
              _DetailRow('Total', 'Rs. ${sale.totalPrice.toStringAsFixed(2)}'),
              _DetailRow('Payment', sale.payment.methodName),
              _DetailRow('Date', DateFormat('dd MMM yyyy, hh:mm a').format(sale.date)),
              if (sale.creditAmount > 0)
                _DetailRow('Credit', 'Rs. ${sale.creditAmount.toStringAsFixed(2)}'),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final serviceAsync = ref.watch(posServiceProvider);

    final content = serviceAsync.when(
      loading: () => const LoadingState(message: 'Loading orders...'),
      error: (err, _) => EmptyState(
        icon: Icons.error_outline,
        title: 'Unable to Load Orders',
        subtitle: 'Unable to load this information. Please try again.',
        onActionPressed: () => ref.refresh(posServiceProvider),
        actionLabel: 'Retry',
        iconColor: AppColors.error,
      ),
      data: (service) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search orders...',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (v) => setState(() => _search = v.trim()),
              ),
            ),
            TabBar(
              controller: _tabController,
              labelColor: AppColors.deepIndigo,
              unselectedLabelColor: AppColors.textSecondary,
              indicatorColor: AppColors.deepIndigo,
              onTap: (_) => setState(() {}),
              tabs: const [
                Tab(text: 'All'),
                Tab(text: 'Today'),
                Tab(text: 'Credit'),
              ],
            ),
            Expanded(
              child: Builder(
                builder: (context) {
                  final filtered = _filter(service.sales, _tabController.index);
                  if (filtered.isEmpty) {
                    return EmptyState(
                      icon: Icons.shopping_cart_outlined,
                      title: 'No Orders Yet',
                      subtitle: 'Orders will appear here when customers place them.',
                      onActionPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SalesScreen()),
                      ),
                      actionLabel: 'New Sale',
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () async => ref.refresh(posServiceProvider),
                    child: ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: filtered.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final sale = filtered[index];
                        return OrderCard(
                          order: sale,
                          onViewDetailsTap: () => _showDetails(context, sale),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );

    if (widget.embedded) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Orders'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              tooltip: 'New Sale',
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SalesScreen()),
              ),
            ),
          ],
        ),
        body: content,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SalesScreen()),
          ),
          icon: const Icon(Icons.point_of_sale),
          label: const Text('New Sale'),
        ),
      );
    }

    return RoleGuard(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Orders'),
          actions: [
            IconButton(
              tooltip: 'New Sale',
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SalesScreen()),
              ),
            ),
          ],
        ),
        body: content,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SalesScreen()),
          ),
          icon: const Icon(Icons.point_of_sale),
          label: const Text('New Sale'),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(label, style: Theme.of(context).textTheme.bodySmall),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

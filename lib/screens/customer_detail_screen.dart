import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/customer.dart';
import '../models/sale.dart';
import '../providers/app_providers.dart';
import '../providers/customer_provider.dart';
import '../utils/date_utils.dart';
import '../utils/validators.dart';
import '../widgets/customer_form.dart';

class CustomerDetailScreen extends ConsumerStatefulWidget {
  final Customer customer;

  const CustomerDetailScreen({
    super.key,
    required this.customer,
  });

  @override
  ConsumerState<CustomerDetailScreen> createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends ConsumerState<CustomerDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(customerListProvider.notifier).loadCustomers();
    });
  }

  void _showEditDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Edit Customer',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                CustomerForm(
                  customer: widget.customer,
                  onSave: (updated) {
                    Navigator.pop(context);
                    ref.read(customerListProvider.notifier).updateCustomer(updated);
                    Navigator.pop(context, updated);
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showRepayCreditDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Repay Credit'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Amount',
            prefixText: 'Rs ',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final amount = double.tryParse(controller.text) ?? 0;
              if (amount > 0) {
                final service = ref.read(customerServiceProvider);
                service.repayCredit(widget.customer.id, amount);
                setState(() {});
              }
              Navigator.pop(context);
            },
            child: const Text('Repay'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final serviceAsync = ref.watch(posServiceProvider);
    final service = serviceAsync.whenOrNull(data: (s) => s);
    final customerService = ref.watch(customerServiceProvider);

    // Refresh customer data
    final freshCustomer = customerService.findById(widget.customer.id) ?? widget.customer;

    final customerSales = service?.sales.where((s) => s.customerId == freshCustomer.id).toList() ?? [];
    customerSales.sort((a, b) => b.date.compareTo(a.date));

    final transactions = customerService.getTransactionsForCustomer(freshCustomer.id);
    final totalPurchaseAmount = customerService.getTotalPurchasesForCustomer(freshCustomer.id, customerSales);
    final duePayments = customerService.getDuePaymentsForCustomer(freshCustomer.id);
    final repeatCustomer = customerService.isRepeatCustomer(freshCustomer.id, customerSales);
    final favoriteProducts = customerService.getFavoriteProducts(freshCustomer.id, customerSales);

    return Scaffold(
      appBar: AppBar(
        title: Text(freshCustomer.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _showEditDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: 16 + MediaQuery.of(context).viewPadding.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            // Info Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.phone, color: Colors.indigo),
                      title: const Text('Phone'),
                      subtitle: Text(freshCustomer.phone),
                    ),
                    if (freshCustomer.email != null)
                      ListTile(
                        leading: const Icon(Icons.email, color: Colors.indigo),
                        title: const Text('Email'),
                        subtitle: Text(freshCustomer.email!),
                      ),
                    if (freshCustomer.address != null)
                      ListTile(
                        leading: const Icon(Icons.location_on, color: Colors.indigo),
                        title: const Text('Address'),
                        subtitle: Text(freshCustomer.address!),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Stats Row
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Loyalty Points',
                    freshCustomer.loyaltyPoints.toStringAsFixed(0),
                    Icons.stars,
                    Colors.amber,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Credit Balance',
                    'Rs ${freshCustomer.creditBalance.toStringAsFixed(2)}',
                    Icons.account_balance_wallet,
                    freshCustomer.creditBalance > 0 ? Colors.red : Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Total Purchases',
                    'Rs ${totalPurchaseAmount.toStringAsFixed(2)}',
                    Icons.shopping_bag,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Due Balance',
                    'Rs ${duePayments.toStringAsFixed(2)}',
                    Icons.schedule,
                    duePayments > 0 ? Colors.orange : Colors.green,
                  ),
                ),
              ],
            ),
            if (repeatCustomer || favoriteProducts.isNotEmpty) ...[
              const SizedBox(height: 16),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (repeatCustomer)
                        Row(
                          children: const [
                            Icon(Icons.repeat, color: Colors.deepPurple),
                            SizedBox(width: 8),
                            Text('Repeat Customer', style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      if (repeatCustomer && favoriteProducts.isNotEmpty)
                        const SizedBox(height: 12),
                      if (favoriteProducts.isNotEmpty) ...[
                        const Text('Favorite Products', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: favoriteProducts
                              .map((product) => Chip(label: Text(product), backgroundColor: Colors.blue.shade50))
                              .toList(),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),

            // Repay Credit Button
            if (freshCustomer.creditBalance > 0)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _showRepayCreditDialog,
                  icon: const Icon(Icons.payment),
                  label: const Text('Repay Credit'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade700,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            if (freshCustomer.creditBalance > 0) const SizedBox(height: 16),

            // Purchase History
            const Text(
              'Purchase History',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (customerSales.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(child: Text('No purchases yet', style: TextStyle(color: Colors.grey))),
              )
            else
              ...customerSales.map((sale) => _buildSaleTile(sale)),

            const SizedBox(height: 24),

            // Credit Transactions
            if (transactions.isNotEmpty) ...[
              const Text(
                'Credit Transactions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...transactions.map((t) => ListTile(
                leading: Icon(
                  t.type == 'credit_sale' ? Icons.arrow_upward : Icons.arrow_downward,
                  color: t.type == 'credit_sale' ? Colors.red : Colors.green,
                ),
                title: Text(t.type == 'credit_sale' ? 'Credit Added' : 'Repayment'),
                subtitle: Text(DateUtilsHelper.formatDateTime(t.date)),
                trailing: Text(
                  'Rs ${t.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: t.type == 'credit_sale' ? Colors.red : Colors.green,
                  ),
                ),
              )),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(title, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
          ],
        ),
      ),
    );
  }

  Future<String?> _promptPhoneNumber(BuildContext context, String? currentPhone) async {
    final controller = TextEditingController(text: currentPhone ?? '');
    String? errorText;
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Send to Phone Number'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Phone number',
                      hintText: '+923001234567',
                      errorText: errorText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('Enter a valid Pakistan number for receipt delivery.', style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                ElevatedButton(
                  onPressed: () {
                    final value = controller.text.trim();
                    final validation = Validators.validatePhoneNumber(value);
                    if (validation != null) {
                      setState(() {
                        errorText = validation;
                      });
                      return;
                    }
                    Navigator.pop(context, value);
                  },
                  child: const Text('Send'),
                ),
              ],
            );
          },
        );
      },
    );
    return result?.isNotEmpty == true ? result : null;
  }

  Widget _buildSaleTile(Sale sale) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: const Icon(Icons.shopping_bag, color: Colors.indigo),
        title: Text(sale.productName, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(DateUtilsHelper.formatDateTime(sale.date)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('Rs ${sale.totalPrice.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
            if (sale.loyaltyPointsEarned > 0)
              Text('+${sale.loyaltyPointsEarned.toStringAsFixed(0)} pts', style: TextStyle(fontSize: 11, color: Colors.amber.shade800)),
            PopupMenuButton<String>(
              onSelected: (choice) async {
                final comm = ref.read(communicationServiceProvider);
                final cust = ref.read(customerServiceProvider).findById(widget.customer.id) ?? widget.customer;
                if (choice == 'whatsapp') {
                  final phone = await _promptPhoneNumber(context, cust.phone);
                  if (phone == null) return;
                  await comm.sendViaWhatsApp(comm.generateInvoiceMessage(cust, sale), phone: phone);
                } else if (choice == 'email') {
                  if (cust.email == null || cust.email!.isEmpty) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Email address not available.')));
                    return;
                  }
                  await comm.sendEmail(cust.email!, 'Invoice', comm.generateInvoiceMessage(cust, sale));
                } else if (choice == 'sms') {
                  final phone = await _promptPhoneNumber(context, cust.phone);
                  if (phone == null) return;
                  await comm.sendSms(phone, comm.generateInvoiceMessage(cust, sale));
                } else if (choice == 'share') {
                  await comm.shareText(comm.generateInvoiceMessage(cust, sale), subject: 'Invoice');
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'whatsapp', child: Text('Send via WhatsApp')),
                const PopupMenuItem(value: 'sms', child: Text('Send via SMS')),
                const PopupMenuItem(value: 'email', child: Text('Send via Email')),
                const PopupMenuItem(value: 'share', child: Text('Share')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


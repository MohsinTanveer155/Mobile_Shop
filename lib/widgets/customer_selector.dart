import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/customer.dart';
import '../providers/customer_provider.dart';
import '../screens/customer_list_screen.dart';

class CustomerSelector extends ConsumerStatefulWidget {
  final Customer? selectedCustomer;
  final Function(Customer?) onCustomerSelected;

  const CustomerSelector({
    super.key,
    this.selectedCustomer,
    required this.onCustomerSelected,
  });

  @override
  ConsumerState<CustomerSelector> createState() => _CustomerSelectorState();
}

class _CustomerSelectorState extends ConsumerState<CustomerSelector> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(customerListProvider.notifier).loadCustomers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(customerListProvider);
    final customers = state.filteredCustomers;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.people, color: Colors.indigo),
                const SizedBox(width: 8),
                const Text(
                  'Customer',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () async {
                    final result = await Navigator.push<Customer>(
                      context,
                      MaterialPageRoute(builder: (_) => const CustomerListScreen()),
                    );
                    if (result != null) {
                      widget.onCustomerSelected(result);
                    }
                  },
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Manage'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<Customer?>(
              decoration: const InputDecoration(
                labelText: 'Select Customer (Optional)',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
              initialValue: widget.selectedCustomer,
              isExpanded: true,
              items: [
                const DropdownMenuItem<Customer?>(
                  value: null,
                  child: Text('Walk-in Customer'),
                ),
                ...customers.map((customer) {
                  return DropdownMenuItem<Customer?>(
                    value: customer,
                    child: Text('${customer.name} (${customer.phone})'),
                  );
                }),
              ],
              onChanged: (customer) {
                widget.onCustomerSelected(customer);
              },
            ),
            if (widget.selectedCustomer != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.indigo.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.stars, size: 18, color: Colors.amber.shade700),
                    const SizedBox(width: 6),
                    Text(
                      '${widget.selectedCustomer!.loyaltyPoints.toStringAsFixed(0)} pts',
                      style: TextStyle(fontWeight: FontWeight.w600, color: Colors.amber.shade800),
                    ),
                    const Spacer(),
                    if (widget.selectedCustomer!.creditBalance > 0)
                      Text(
                        'Credit: Rs ${widget.selectedCustomer!.creditBalance.toStringAsFixed(2)}',
                        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.red.shade700),
                      ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}


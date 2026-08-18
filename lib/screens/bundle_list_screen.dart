import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_bundle.dart';
import '../models/product.dart';
import '../providers/app_providers.dart';
import '../widgets/role_guard.dart';
import 'bundle_sale_screen.dart';

class BundleListScreen extends ConsumerStatefulWidget {
  const BundleListScreen({super.key});

  @override
  ConsumerState<BundleListScreen> createState() => _BundleListScreenState();
}

class _BundleListScreenState extends ConsumerState<BundleListScreen> {
  void _showAddBundleDialog() {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final discountController = TextEditingController(text: '0');
    final List<BundleItem> items = [];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Create Bundle'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Bundle Name',
                        border: OutlineInputBorder(),
                        hintText: 'e.g. iPhone Starter Pack',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description (Optional)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text('Items in Bundle', style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 8),
                    ...items.map((item) => ListTile(
                      dense: true,
                      title: Text(item.productName, style: const TextStyle(fontSize: 13)),
                      subtitle: Text('Qty: ${item.quantity} · Rs ${item.unitPrice.toStringAsFixed(2)}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline, size: 18),
                        onPressed: () {
                          setDialogState(() {
                            items.remove(item);
                          });
                        },
                      ),
                    )),
                    TextButton.icon(
                      onPressed: () => _showAddItemDialog(items, setDialogState),
                      icon: const Icon(Icons.add),
                      label: const Text('Add Item'),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: discountController,
                      decoration: const InputDecoration(
                        labelText: 'Discount %',
                        border: OutlineInputBorder(),
                        suffixText: '%',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    if (items.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      _buildPricePreview(items, double.tryParse(discountController.text) ?? 0),
                    ],
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final name = nameController.text.trim();
                    if (name.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter bundle name.')),
                      );
                      return;
                    }
                    if (items.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Add at least one item.')),
                      );
                      return;
                    }

                    final discount = double.tryParse(discountController.text) ?? 0;
                    ref.read(bundleServiceProvider).whenData((service) {
                      service.createBundle(
                        name: name,
                        description: descriptionController.text.trim().isEmpty ? null : descriptionController.text.trim(),
                        items: List.from(items),
                        discountPercent: discount.clamp(0, 100),
                      );
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Bundle created successfully.')),
                      );
                      setState(() {});
                    });
                  },
                  child: const Text('Create Bundle'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showAddItemDialog(List<BundleItem> items, void Function(void Function()) setDialogState) {
    final posAsync = ref.read(posServiceProvider);
    final productNameController = TextEditingController();
    final quantityController = TextEditingController(text: '1');
    final priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setItemState) {
            return AlertDialog(
              scrollable: true,
              title: const Text('Add Item to Bundle'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    posAsync.when(
                      loading: () => const CircularProgressIndicator(),
                      error: (_, __) => const Text('Error loading products'),
                      data: (service) {
                        return DropdownButtonFormField<Product>(
                          decoration: const InputDecoration(
                            labelText: 'Select Product',
                            border: OutlineInputBorder(),
                          ),
                          items: service.products.map((product) {
                            return DropdownMenuItem(
                              value: product,
                              child: Text('${product.name} (Rs ${product.price.toStringAsFixed(2)})'),
                            );
                          }).toList(),
                          onChanged: (product) {
                            setItemState(() {
                              productNameController.text = product?.name ?? '';
                              priceController.text = product?.price.toStringAsFixed(2) ?? '';
                            });
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: quantityController,
                      decoration: const InputDecoration(
                        labelText: 'Quantity',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: priceController,
                      decoration: const InputDecoration(
                        labelText: 'Unit Price',
                        border: OutlineInputBorder(),
                        prefixText: 'Rs ',
                      ),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final name = productNameController.text.trim();
                    final quantity = int.tryParse(quantityController.text) ?? 0;
                    final price = double.tryParse(priceController.text) ?? 0;

                    if (name.isEmpty || quantity <= 0 || price <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill all fields correctly.')),
                      );
                      return;
                    }

                    setDialogState(() {
                      items.add(BundleItem(
                        productName: name,
                        quantity: quantity,
                        unitPrice: price,
                      ));
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildPricePreview(List<BundleItem> items, double discountPercent) {
    final subtotal = items.fold(0.0, (sum, item) => sum + item.totalPrice);
    final discount = subtotal * (discountPercent / 100);
    final finalPrice = subtotal - discount;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _priceRow('Subtotal', 'Rs ${subtotal.toStringAsFixed(2)}'),
          if (discount > 0) _priceRow('Discount', '-Rs ${discount.toStringAsFixed(2)}', color: Colors.green),
          const Divider(),
          _priceRow('Final Price', 'Rs ${finalPrice.toStringAsFixed(2)}', isBold: true),
        ],
      ),
    );
  }

  Widget _priceRow(String label, String value, {Color? color, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  void _deleteBundle(String bundleId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Bundle'),
        content: const Text('Are you sure you want to delete this bundle?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(bundleServiceProvider).whenData((service) {
                service.deleteBundle(bundleId);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Bundle deleted.')),
                );
                setState(() {});
              });
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bundleAsync = ref.watch(bundleServiceProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return RoleGuard(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Product Bundles'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _showAddBundleDialog,
            ),
          ],
        ),
        body: bundleAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
          data: (service) {
            final bundles = service.bundles;

            return bundles.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inventory_2_outlined, size: 64, color: colorScheme.onSurface.withValues(alpha: 0.3)),
                        const SizedBox(height: 16),
                        Text(
                          'No bundles created yet',
                          style: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.5)),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: bundles.length,
                    itemBuilder: (context, index) {
                      final bundle = bundles[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: colorScheme.primary.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(Icons.inventory_2, color: colorScheme.primary),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          bundle.name,
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                        ),
                                        if (bundle.description != null)
                                          Text(
                                            bundle.description!,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: colorScheme.onSurface.withValues(alpha: 0.6),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  if (bundle.discountPercent > 0)
                                    Chip(
                                      label: Text('-${bundle.discountPercent.toStringAsFixed(0)}%'),
                                      backgroundColor: Colors.green.withValues(alpha: 0.1),
                                      labelStyle: const TextStyle(color: Colors.green, fontSize: 11),
                                      visualDensity: VisualDensity.compact,
                                    ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              ...bundle.items.map((item) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2),
                                child: Row(
                                  children: [
                                    const Icon(Icons.check_circle, size: 14, color: Colors.green),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        '${item.productName} x${item.quantity}',
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                    ),
                                    Text(
                                      'Rs ${item.totalPrice.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                              const Divider(height: 24),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Rs ${bundle.finalPrice.toStringAsFixed(2)}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: colorScheme.primary,
                                          ),
                                        ),
                                        if (bundle.discountAmount > 0)
                                          Text(
                                            'Save Rs ${bundle.discountAmount.toStringAsFixed(2)}',
                                            style: const TextStyle(
                                              fontSize: 11,
                                              color: Colors.green,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.shopping_cart),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => BundleSaleScreen(bundleId: bundle.id),
                                            ),
                                          );
                                        },
                                        tooltip: 'Sell Bundle',
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                                        onPressed: () => _deleteBundle(bundle.id),
                                        tooltip: 'Delete',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showAddBundleDialog,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../models/product_bundle.dart';
import '../models/payment.dart';
import '../models/customer.dart';
import '../providers/app_providers.dart';
import '../services/payment_validator.dart';
import '../widgets/customer_selector.dart';
import '../widgets/payment_method_selector.dart';
import '../widgets/payment_details_form.dart';

class BundleSaleScreen extends ConsumerStatefulWidget {
  final String bundleId;

  const BundleSaleScreen({super.key, required this.bundleId});

  @override
  ConsumerState<BundleSaleScreen> createState() => _BundleSaleScreenState();
}

class _BundleSaleScreenState extends ConsumerState<BundleSaleScreen> {
  PaymentMethod _selectedPaymentMethod = PaymentMethod.cash;
  String? _transactionId;
  String? _notes;
  String? _accountNumber;
  Customer? _selectedCustomer;

  void _confirmSale(ProductBundle bundle, List<Product> availableProducts) {
    // Validate stock
    for (final item in bundle.items) {
      final product = availableProducts.firstWhere(
        (p) => p.name == item.productName,
        orElse: () => Product(name: '', price: 0, quantity: 0),
      );
      if (product.name.isEmpty || product.quantity < item.quantity) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Insufficient stock for ${item.productName}')),
        );
        return;
      }
    }

    // Validate payment based on payment method
    final paymentErrors = PaymentValidator.validatePayment(
      _selectedPaymentMethod,
      bundle.finalPrice,
      transactionId: _transactionId,
      accountNumber: _accountNumber,
      notes: _notes,
    );

    if (paymentErrors.isNotEmpty) {
      final errorMessages = paymentErrors.values
          .where((e) => e != null)
          .join('\n');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessages),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
      return;
    }

    final payment = Payment(
      method: _selectedPaymentMethod,
      amount: bundle.finalPrice,
      timestamp: DateTime.now(),
      transactionId: _transactionId,
      notes: _notes,
      accountNumber: _accountNumber,
    );

    final scaffoldMessenger = ScaffoldMessenger.of(context);
    ref.read(posServiceProvider).whenData((service) {
      final paymentService = ref.read(paymentServiceProvider);

      paymentService.processPayment(payment).then((result) {
        if (!result.success) {
          scaffoldMessenger.showSnackBar(
            SnackBar(
              content: Text(result.error ?? 'Payment processing failed.'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        // Deduct stock and create sale records for all items
        for (final item in bundle.items) {
          final productIndex = service.products.indexWhere((p) => p.name == item.productName);
          if (productIndex == -1) continue;

          final product = service.products[productIndex];
          service.sellProductToCustomer(
            product,
            item.quantity,
            payment,
            _selectedCustomer?.id,
            0.0,
            _selectedPaymentMethod == PaymentMethod.credit ? bundle.finalPrice : 0.0,
          );
        }

        scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Bundle sold: ${bundle.name}')),
        );

        // Check for low stock
        final notificationService = ref.read(notificationServiceProvider);
        final notificationState = ref.read(notificationProvider);
        if (notificationState.notificationsEnabled && notificationState.lowStockEnabled) {
          notificationService.checkLowStock(
            service.products,
            threshold: notificationState.lowStockThreshold,
          );
        }

        if (mounted) Navigator.pop(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final bundleAsync = ref.watch(bundleServiceProvider);
    final posAsync = ref.watch(posServiceProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Sell Bundle')),
      body: bundleAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (bundleService) {
          final bundle = bundleService.findById(widget.bundleId);
          if (bundle == null) {
            return const Center(child: Text('Bundle not found.'));
          }

          return posAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
            data: (posService) {
              final canSell = bundleService.canSellBundle(bundle, posService.products);

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              bundle.name,
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            if (bundle.description != null) ...[
                              const SizedBox(height: 4),
                              Text(
                                bundle.description!,
                                style: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.6)),
                              ),
                            ],
                            const SizedBox(height: 16),
                            ...bundle.items.map((item) {
                              final product = posService.products.firstWhere(
                                (p) => p.name == item.productName,
                                orElse: () => Product(name: '', price: 0, quantity: 0),
                              );
                              final hasStock = product.name.isNotEmpty && product.quantity >= item.quantity;

                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  children: [
                                    Icon(
                                      hasStock ? Icons.check_circle : Icons.error,
                                      color: hasStock ? Colors.green : Colors.red,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        '${item.productName} x${item.quantity}',
                                        style: TextStyle(
                                          decoration: hasStock ? null : TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ),
                                    Text('Rs ${item.totalPrice.toStringAsFixed(2)}'),
                                  ],
                                ),
                              );
                            }),
                            const Divider(height: 32),
                            if (bundle.discountAmount > 0) ...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Subtotal'),
                                  Text('Rs ${bundle.subtotal.toStringAsFixed(2)}'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Discount (${bundle.discountPercent.toStringAsFixed(0)}%)'),
                                  Text(
                                    '-Rs ${bundle.discountAmount.toStringAsFixed(2)}',
                                    style: const TextStyle(color: Colors.green),
                                  ),
                                ],
                              ),
                            ],
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                                Text(
                                  'Rs ${bundle.finalPrice.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (!canSell)
                      Card(
                        color: Colors.red.withValues(alpha: 0.1),
                        child: const Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Icon(Icons.error, color: Colors.red),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Cannot sell: One or more items are out of stock.',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (canSell) ...[
                      CustomerSelector(
                        selectedCustomer: _selectedCustomer,
                        onCustomerSelected: (customer) {
                          setState(() {
                            _selectedCustomer = customer;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      PaymentMethodSelector(
                        initialMethod: _selectedPaymentMethod,
                        onMethodSelected: (method) {
                          setState(() {
                            _selectedPaymentMethod = method;
                          });
                        },
                      ),
                      PaymentDetailsForm(
                        paymentMethod: _selectedPaymentMethod,
                        onDetailsChanged: (transactionId, notes, accountNumber) {
                          _transactionId = transactionId;
                          _notes = notes;
                          _accountNumber = accountNumber;
                        },
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () => _confirmSale(bundle, posService.products),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('Confirm Sale', style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}


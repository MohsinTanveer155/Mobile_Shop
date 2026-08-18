import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/customer.dart';
import '../models/payment.dart';
import '../models/product.dart';
import '../models/sale.dart';
import '../providers/app_providers.dart';
import '../services/payment_validator.dart';
import '../utils/validators.dart';
import '../widgets/customer_selector.dart';
import '../widgets/payment_method_selector.dart';
import '../widgets/payment_details_form.dart';
import 'add_product_screen.dart';
import 'barcode_scanner_screen.dart';

class SalesScreen extends ConsumerStatefulWidget {
  const SalesScreen({super.key});

  @override
  ConsumerState<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends ConsumerState<SalesScreen> {
  Product? _selectedProduct;
  final TextEditingController _quantityController = TextEditingController();
  PaymentMethod _selectedPaymentMethod = PaymentMethod.cash;
  String? _transactionId;
  String? _notes;
  String? _accountNumber;
  Customer? _selectedCustomer;
  double _loyaltyPointsToRedeem = 0.0;

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
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
                  const Text('Enter the customer number where you want to send the receipt.', style: TextStyle(fontSize: 12, color: Colors.grey)),
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

  Widget _buildSendOptionsSheet(BuildContext context, Customer customer, Sale sale, dynamic communicationService, bool hasDue) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Send Receipt', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.chat),
              label: const Text('Send via WhatsApp'),
              onPressed: () async {
                final phone = await _promptPhoneNumber(context, customer.phone);
                if (phone == null) return;
                if (!mounted) return;
                Navigator.pop(this.context);
                await communicationService.sendViaWhatsApp(communicationService.generateInvoiceMessage(customer, sale), phone: phone);
              },
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              icon: const Icon(Icons.email),
              label: const Text('Send via Email'),
              onPressed: () async {
                if (customer.email == null || customer.email!.isEmpty) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(this.context).showSnackBar(const SnackBar(content: Text('Email address not available.')));
                  return;
                }
                if (!mounted) return;
                Navigator.pop(this.context);
                await communicationService.sendEmail(customer.email!, 'Your Invoice', communicationService.generateInvoiceMessage(customer, sale));
              },
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              icon: const Icon(Icons.message),
              label: const Text('Send via SMS'),
              onPressed: () async {
                final phone = await _promptPhoneNumber(context, customer.phone);
                if (phone == null) return;
                if (!mounted) return;
                Navigator.pop(this.context);
                await communicationService.sendSms(phone, communicationService.generateInvoiceMessage(customer, sale));
              },
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              icon: const Icon(Icons.share),
              label: const Text('Share (other apps)'),
              onPressed: () async {
                if (!mounted) return;
                Navigator.pop(this.context);
                await communicationService.shareText(communicationService.generateInvoiceMessage(customer, sale), subject: 'Invoice');
              },
            ),
            if (hasDue) ...[
              const SizedBox(height: 12),
              Text('Payment Reminder', style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                icon: const Icon(Icons.notifications_active),
                label: const Text('Send Payment Reminder (WhatsApp)'),
                onPressed: () async {
                  final phone = await _promptPhoneNumber(context, customer.phone);
                  if (phone == null) return;
                  if (!mounted) return;
                  Navigator.pop(this.context);
                  await communicationService.sendViaWhatsApp(communicationService.generatePaymentReminder(customer, sale.creditAmount), phone: phone);
                },
              ),
            ],
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  double get _baseTotalPrice {
    if (_selectedProduct == null) {
      return 0.0;
    }
    final quantity = int.tryParse(_quantityController.text) ?? 0;
    return _selectedProduct!.price * quantity;
  }

  double get _totalPrice {
    double total = _baseTotalPrice;
    // Apply loyalty discount
    total -= _loyaltyPointsToRedeem;
    // Credit doesn't reduce the displayed total, it just defers payment
    return total > 0 ? total : 0;
  }

  Future<void> _confirmSale() async {
    if (_selectedProduct == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Select a product first.')));
      return;
    }

    final quantity = int.tryParse(_quantityController.text.trim()) ?? -1;
    if (quantity <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter a valid sale quantity.')));
      return;
    }

    if (quantity > _selectedProduct!.quantity) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Quantity exceeds available stock.')));
      return;
    }

    // Validate payment details based on payment method
    final paymentErrors = PaymentValidator.validatePayment(
      _selectedPaymentMethod,
      _totalPrice,
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

    // Create payment
    final payment = Payment(
      method: _selectedPaymentMethod,
      amount: _totalPrice,
      timestamp: DateTime.now(),
      transactionId: _transactionId,
      notes: _notes,
      accountNumber: _accountNumber,
    );

    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final communicationService = ref.read(communicationServiceProvider);

    ref.read(posServiceProvider).whenData((service) {
      final paymentService = ref.read(paymentServiceProvider);
      paymentService.processPayment(payment).then((result) async {
        if (!result.success) {
          scaffoldMessenger.showSnackBar(
            SnackBar(
              content: Text(result.error ?? 'Payment processing failed. Please try again.'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        final sale = service.sellProductToCustomer(
          _selectedProduct!,
          quantity,
          payment,
          _selectedCustomer?.id,
          _loyaltyPointsToRedeem,
          _selectedPaymentMethod == PaymentMethod.credit ? _baseTotalPrice : 0.0,
        );
        if (sale == null) {
          scaffoldMessenger.showSnackBar(
            const SnackBar(content: Text('Could not complete sale.')),
          );
          return;
        }

        scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Sale confirmed: ${sale.quantity} x ${sale.productName}')),
        );

        if (_selectedCustomer != null) {
          final warrantyService = await ref.read(warrantyServiceProvider.future);
          warrantyService.createWarranty(
            productName: sale.productName,
            customerId: _selectedCustomer!.id,
            customerName: _selectedCustomer!.name,
            customerPhone: _selectedCustomer!.phone,
            purchaseDate: sale.date,
          );
          // Offer explicit send options to the user for invoice, payment reminder and warranty
           if (!mounted) return;
           await showModalBottomSheet<void>(
             context: context,
             builder: (c) => _buildSendOptionsSheet(c, _selectedCustomer!, sale, communicationService, sale.creditAmount > 0),
           );
        }

        _resetForm();
        setState(() {});
      });
    });
  }

  void _resetForm() {
    _quantityController.clear();
    _selectedProduct = null;
    _selectedPaymentMethod = PaymentMethod.cash;
    _transactionId = null;
    _notes = null;
    _accountNumber = null;
    _selectedCustomer = null;
    _loyaltyPointsToRedeem = 0.0;
  }

  Future<void> _scanBarcode() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final barcode = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const BarcodeScannerScreen()),
    );

    if (barcode == null || barcode.isEmpty) return;

    ref.read(posServiceProvider).whenData((service) {
      final product = service.findProductByBarcode(barcode);
      if (product != null) {
        setState(() {
          _selectedProduct = product;
          _quantityController.text = '1';
        });
        scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Found: ${product.name}')),
        );
      } else {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text('No product found for barcode: $barcode'),
            action: SnackBarAction(
              label: 'Add Product',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddProductScreen()),
                );
              },
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final serviceAsync = ref.watch(posServiceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Sales Screen')),
      body: serviceAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (service) {
          final productList = service.products;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'New Sale',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    onTap: _scanBarcode,
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.indigo.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.qr_code_scanner, color: Colors.indigo, size: 28),
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Scan Barcode',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Tap to scan product barcode for fast billing',
                                  style: TextStyle(fontSize: 13, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<Product>(
                  decoration: const InputDecoration(
                    labelText: 'Choose Product',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: _selectedProduct,
                  items: productList.map((product) {
                    return DropdownMenuItem(
                      value: product,
                      child: Text('${product.name} (Stock: ${product.quantity})'),
                    );
                  }).toList(),
                  onChanged: (product) {
                    setState(() {
                      _selectedProduct = product;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Sale Quantity',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Total Price', style: TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        Text(
                          'Rs ${_totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CustomerSelector(
                  selectedCustomer: _selectedCustomer,
                  onCustomerSelected: (customer) {
                    setState(() {
                      _selectedCustomer = customer;
                      _loyaltyPointsToRedeem = 0.0;
                    });
                  },
                ),
                const SizedBox(height: 16),
                if (_selectedCustomer != null && _selectedCustomer!.loyaltyPoints > 0) ...[
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.stars, color: Colors.amber.shade700),
                              const SizedBox(width: 8),
                              const Text(
                                'Loyalty Points',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              const Spacer(),
                              Text(
                                'Available: ${_selectedCustomer!.loyaltyPoints.toStringAsFixed(0)}',
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Points to Redeem',
                              border: OutlineInputBorder(),
                              helperText: '1 point = Rs 1 discount',
                            ),
                            onChanged: (value) {
                              final points = double.tryParse(value) ?? 0;
                              setState(() {
                                _loyaltyPointsToRedeem = points.clamp(
                                  0,
                                  _selectedCustomer!.loyaltyPoints,
                                );
                              });
                            },
                          ),
                          if (_loyaltyPointsToRedeem > 0)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                'Discount: -Rs ${_loyaltyPointsToRedeem.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: Colors.green.shade700,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                PaymentMethodSelector(
                  initialMethod: _selectedPaymentMethod,
                  onMethodSelected: (method) {
                    setState(() {
                      _selectedPaymentMethod = method;
                      _transactionId = null;
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
                  onPressed: _confirmSale,
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                  child: const Text('Confirm Sale'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

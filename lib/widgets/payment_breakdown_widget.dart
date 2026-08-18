import 'package:flutter/material.dart';
import '../models/payment.dart';
import '../models/sale.dart';

class PaymentBreakdownWidget extends StatelessWidget {
  final List<Sale> sales;

  const PaymentBreakdownWidget({
    super.key,
    required this.sales,
  });

  @override
  Widget build(BuildContext context) {
    final breakdown = _getPaymentBreakdown();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Breakdown',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...breakdown.entries.map((entry) {
          final method = entry.key;
          final amount = entry.value;
          final percentage = sales.isNotEmpty ? (amount / _getTotalAmount() * 100) : 0.0;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                _getPaymentIcon(method),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getMethodName(method),
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      LinearProgressIndicator(
                        value: percentage / 100,
                        minHeight: 6,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Rs ${amount.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Map<PaymentMethod, double> _getPaymentBreakdown() {
    final breakdown = <PaymentMethod, double>{};
    for (final method in PaymentMethod.values) {
      breakdown[method] = 0.0;
    }
    for (final sale in sales) {
      breakdown[sale.payment.method] = (breakdown[sale.payment.method] ?? 0.0) + sale.totalPrice;
    }
    return breakdown;
  }

  double _getTotalAmount() {
    return _getPaymentBreakdown().values.fold(0.0, (sum, amount) => sum + amount);
  }

  Widget _getPaymentIcon(PaymentMethod method) {
    IconData icon;
    Color color;
    switch (method) {
      case PaymentMethod.cash:
        icon = Icons.currency_rupee;
        color = Colors.green;
        break;
      case PaymentMethod.card:
        icon = Icons.credit_card;
        color = Colors.blue;
        break;
      case PaymentMethod.bankTransfer:
        icon = Icons.account_balance;
        color = Colors.purple;
        break;
      case PaymentMethod.jazzCash:
        icon = Icons.phone_in_talk;
        color = Colors.red;
        break;
      case PaymentMethod.easyPaisa:
        icon = Icons.phone_in_talk;
        color = Colors.orange;
        break;
      case PaymentMethod.credit:
        icon = Icons.account_balance_wallet;
        color = Colors.amber;
        break;
    }
    return Icon(icon, color: color, size: 24);
  }

  String _getMethodName(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.cash:
        return 'Cash';
      case PaymentMethod.card:
        return 'Card';
      case PaymentMethod.bankTransfer:
        return 'Bank Transfer';
      case PaymentMethod.jazzCash:
        return 'JazzCash';
      case PaymentMethod.easyPaisa:
        return 'EasyPaisa';
      case PaymentMethod.credit:
        return 'Credit';
    }
  }
}

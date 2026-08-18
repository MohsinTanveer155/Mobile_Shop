import 'package:flutter/material.dart';
import '../models/payment.dart';

class PaymentMethodSelector extends StatefulWidget {
  final Function(PaymentMethod) onMethodSelected;
  final PaymentMethod? initialMethod;

  const PaymentMethodSelector({
    super.key,
    required this.onMethodSelected,
    this.initialMethod,
  });

  @override
  State<PaymentMethodSelector> createState() => _PaymentMethodSelectorState();
}

class _PaymentMethodSelectorState extends State<PaymentMethodSelector> {
  late PaymentMethod _selectedMethod;

  @override
  void initState() {
    super.initState();
    _selectedMethod = widget.initialMethod ?? PaymentMethod.cash;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Method',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Row(
          children: PaymentMethod.values.map((method) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ChoiceChip(
                  label: Text(_getMethodLabel(method)),
                  selected: _selectedMethod == method,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedMethod = method;
                      });
                      widget.onMethodSelected(method);
                    }
                  },
                  avatar: _getMethodIcon(method),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  String _getMethodLabel(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.cash:
        return 'Cash';
      case PaymentMethod.card:
        return 'Card';
      case PaymentMethod.bankTransfer:
        return 'Transfer';
      case PaymentMethod.jazzCash:
        return 'JazzCash';
      case PaymentMethod.easyPaisa:
        return 'EasyPaisa';
      case PaymentMethod.credit:
        return 'Credit';
    }
  }

  Widget _getMethodIcon(PaymentMethod method) {
    IconData icon;
    Color color;
    switch (method) {
      case PaymentMethod.cash:
        icon = Icons.attach_money;
        color = Colors.green;
        break;
      case PaymentMethod.card:
        icon = Icons.payment;
        color = Colors.blue;
        break;
      case PaymentMethod.bankTransfer:
        icon = Icons.swap_horiz;
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
        icon = Icons.credit_score;
        color = Colors.orange;
        break;
    }
    return Icon(icon, color: color, size: 18);
  }
}

import 'package:flutter/material.dart';
import '../models/payment.dart';
import '../utils/validators.dart';

class PaymentDetailsForm extends StatefulWidget {
  final PaymentMethod paymentMethod;
  final Function(String? transactionId, String? notes, String? accountNumber) onDetailsChanged;

  const PaymentDetailsForm({
    super.key,
    required this.paymentMethod,
    required this.onDetailsChanged,
  });

  @override
  State<PaymentDetailsForm> createState() => _PaymentDetailsFormState();
}

class _PaymentDetailsFormState extends State<PaymentDetailsForm> {
  final TextEditingController _transactionIdController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  String? _accountNumberError;

  @override
  void didUpdateWidget(PaymentDetailsForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.paymentMethod != widget.paymentMethod) {
      _transactionIdController.clear();
      _notesController.clear();
      _accountNumberController.clear();
      _accountNumberError = null;
    }
  }

  @override
  void dispose() {
    _transactionIdController.dispose();
    _notesController.dispose();
    _accountNumberController.dispose();
    super.dispose();
  }

  void _validateAccountNumber(String value) {
    if (value.isNotEmpty) {
      final error = Validators.validateAccountNumber(value);
      setState(() {
        _accountNumberError = error;
      });
    } else {
      setState(() {
        _accountNumberError = null;
      });
    }
    _notifyChanges();
  }

  @override
  Widget build(BuildContext context) {
    // Show details only for non-cash payments
    if (widget.paymentMethod == PaymentMethod.cash ||
        widget.paymentMethod == PaymentMethod.credit) {
      return const SizedBox.shrink();
    }

    final isMobilePayment = widget.paymentMethod == PaymentMethod.jazzCash ||
        widget.paymentMethod == PaymentMethod.easyPaisa;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Account number field for mobile payments
        if (isMobilePayment) ...[
          const SizedBox(height: 16),
          const Text(
            'Account Number',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _accountNumberController,
            decoration: InputDecoration(
              hintText: 'e.g., 03001234567',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: _accountNumberError != null ? Colors.red : Colors.grey,
                ),
              ),
              prefixIcon: const Icon(Icons.phone),
              errorText: _accountNumberError,
              errorMaxLines: 2,
            ),
            keyboardType: TextInputType.phone,
            onChanged: _validateAccountNumber,
          ),
        ],
        const SizedBox(height: 16),
        Text(
          _getPaymentFieldLabel(),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _transactionIdController,
          decoration: InputDecoration(
            hintText: _getTransactionIdHint(),
            border: const OutlineInputBorder(),
            prefixIcon: Icon(_getTransactionIdIcon()),
          ),
          onChanged: (_) => _notifyChanges(),
        ),
        const SizedBox(height: 12),
        const Text(
          'Notes (Optional)',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _notesController,
          decoration: const InputDecoration(
            hintText: 'Add any additional notes',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.notes),
          ),
          maxLines: 2,
          onChanged: (_) => _notifyChanges(),
        ),
      ],
    );
  }

  String _getPaymentFieldLabel() {
    switch (widget.paymentMethod) {
      case PaymentMethod.card:
        return 'Card Reference Number';
      case PaymentMethod.bankTransfer:
        return 'Bank Transfer Reference';
      case PaymentMethod.jazzCash:
        return 'JazzCash Transaction Reference';
      case PaymentMethod.easyPaisa:
        return 'EasyPaisa Transaction Reference';
      default:
        return '';
    }
  }

  String _getTransactionIdHint() {
    switch (widget.paymentMethod) {
      case PaymentMethod.card:
        return 'e.g., 4532-1234-5678-9012';
      case PaymentMethod.bankTransfer:
        return 'e.g., TXN123456789';
      case PaymentMethod.jazzCash:
        return 'e.g., JC123456789';
      case PaymentMethod.easyPaisa:
        return 'e.g., EP123456789';
      default:
        return '';
    }
  }

  IconData _getTransactionIdIcon() {
    switch (widget.paymentMethod) {
      case PaymentMethod.card:
        return Icons.credit_card;
      case PaymentMethod.bankTransfer:
        return Icons.account_balance;
      case PaymentMethod.jazzCash:
        return Icons.phone_in_talk;
      case PaymentMethod.easyPaisa:
        return Icons.phone_in_talk;
      default:
        return Icons.payment;
    }
  }

  void _notifyChanges() {
    widget.onDetailsChanged(
      _transactionIdController.text.trim().isEmpty
          ? null
          : _transactionIdController.text.trim(),
      _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
      _accountNumberController.text.trim().isEmpty
          ? null
          : _accountNumberController.text.trim(),
    );
  }
}

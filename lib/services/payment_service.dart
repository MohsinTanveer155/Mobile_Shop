import '../models/payment.dart';
import '../utils/validators.dart';
import 'payment_validator.dart';

/// Payment service handling different payment methods.
/// Extensible for future integration with payment gateways (Stripe, PayPal, etc).
class PaymentService {
  /// Process a payment with validation
  Future<PaymentResult> processPayment(
    Payment payment, {
    String? accountNumber,
  }) async {
    try {
      // Simulate payment processing
      await Future.delayed(const Duration(milliseconds: 500));

      // Validate payment
      if (payment.amount <= 0) {
        return PaymentResult(
          success: false,
          error: 'Amount must be greater than zero',
        );
      }

      // Validate payment based on method
      final errors = PaymentValidator.validatePayment(
        payment.method,
        payment.amount,
        transactionId: payment.transactionId,
        accountNumber: accountNumber ?? payment.accountNumber,
        notes: payment.notes,
      );

      if (errors.isNotEmpty) {
        final errorMessages = errors.values
            .where((e) => e != null)
            .join(', ');
        return PaymentResult(
          success: false,
          error: errorMessages,
        );
      }

      // Process based on payment method
      final result = switch (payment.method) {
        PaymentMethod.cash => _processCashPayment(payment),
        PaymentMethod.card => _processCardPayment(payment),
        PaymentMethod.bankTransfer => _processBankTransfer(payment),
        PaymentMethod.jazzCash =>
          _processMobilePayment(payment, 'JazzCash'),
        PaymentMethod.easyPaisa =>
          _processMobilePayment(payment, 'EasyPaisa'),
        PaymentMethod.credit => PaymentResult(success: true),
      };

      return result;
    } catch (e) {
      return PaymentResult(
        success: false,
        error: 'Payment processing failed: ${e.toString()}',
      );
    }
  }

  /// Process cash payment (simplest, always successful)
  PaymentResult _processCashPayment(Payment payment) {
    return PaymentResult(
      success: true,
      message: 'Cash payment received: Rs ${payment.amount.toStringAsFixed(2)}',
    );
  }

  /// Process card payment (could integrate with payment gateway)
  PaymentResult _processCardPayment(Payment payment) {
    if (payment.transactionId == null || payment.transactionId!.isEmpty) {
      return PaymentResult(
        success: false,
        error: 'Card transaction ID is required',
      );
    }

    return PaymentResult(
      success: true,
      message:
          'Card payment processed. Ref: ${payment.transactionId}',
    );
  }

  /// Process bank transfer (could integrate with banking APIs)
  PaymentResult _processBankTransfer(Payment payment) {
    if (payment.transactionId == null || payment.transactionId!.isEmpty) {
      return PaymentResult(
        success: false,
        error: 'Bank transfer reference is required',
      );
    }

    return PaymentResult(
      success: true,
      message:
          'Bank transfer recorded. Ref: ${payment.transactionId}',
    );
  }

  /// Process mobile payments (JazzCash/EasyPaisa)
  PaymentResult _processMobilePayment(Payment payment, String provider) {
    final accountNumber = payment.accountNumber;
    if (accountNumber == null || accountNumber.isEmpty) {
      return PaymentResult(
        success: false,
        error: '$provider account number is required',
      );
    }

    final accountError = Validators.validateAccountNumber(accountNumber);
    if (accountError != null) {
      return PaymentResult(
        success: false,
        error: accountError,
      );
    }

    if (payment.transactionId == null || payment.transactionId!.isEmpty) {
      return PaymentResult(
        success: false,
        error: 'Transaction reference is required',
      );
    }

    return PaymentResult(
      success: true,
      message:
          '$provider payment processed. Account: ${_maskAccountNumber(accountNumber)}, Ref: ${payment.transactionId}',
    );
  }

  /// Mask account number for display (show only last 4 digits)
  String _maskAccountNumber(String account) {
    if (account.length <= 4) return '****';
    return '****${account.substring(account.length - 4)}';
  }

  /// Get payment method description for UI
  String getPaymentDescription(Payment payment) {
    final buffer =
        StringBuffer('${payment.methodName} - Rs ${payment.amount.toStringAsFixed(2)}');

    if (payment.transactionId != null && payment.transactionId!.isNotEmpty) {
      buffer.write(' (Ref: ${payment.transactionId})');
    }

    if (payment.accountNumber != null && payment.accountNumber!.isNotEmpty) {
      buffer.write(' (Account: ${_maskAccountNumber(payment.accountNumber!)})');
    }

    return buffer.toString();
  }

  /// Get payment method icon name
  String getPaymentMethodIcon(PaymentMethod method) {
    return switch (method) {
      PaymentMethod.cash => 'local_atm',
      PaymentMethod.card => 'credit_card',
      PaymentMethod.bankTransfer => 'account_balance',
      PaymentMethod.jazzCash => 'phone_in_talk',
      PaymentMethod.easyPaisa => 'phone_in_talk',
      PaymentMethod.credit => 'schedule',
    };
  }
}

/// Result class for payment processing
class PaymentResult {
  final bool success;
  final String? error;
  final String? message;

  PaymentResult({
    required this.success,
    this.error,
    this.message,
  });
}

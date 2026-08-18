import '../models/payment.dart';

/// Payment validation service - Clean Architecture layer for payment validation
/// Handles validation of different payment methods and their requirements
class PaymentValidator {
  /// Validate payment data based on payment method
  static Map<String, String?> validatePayment(
    PaymentMethod method,
    double amount, {
    String? transactionId,
    String? accountNumber,
    String? notes,
  }) {
    final errors = <String, String?>{};

    // Validate amount
    if (amount <= 0) {
      errors['amount'] = 'Amount must be greater than 0';
    }

    // Method-specific validation
    switch (method) {
      case PaymentMethod.cash:
        // Cash doesn't need additional validation
        break;

      case PaymentMethod.card:
        if (transactionId == null || transactionId.trim().isEmpty) {
          errors['transactionId'] = 'Card transaction ID is required';
        } else if (!_isValidCardTransactionId(transactionId)) {
          errors['transactionId'] = 'Invalid card transaction ID format';
        }
        break;

      case PaymentMethod.bankTransfer:
        if (transactionId == null || transactionId.trim().isEmpty) {
          errors['transactionId'] = 'Bank transfer reference/account number is required';
        } else if (!_isValidBankReference(transactionId)) {
          errors['transactionId'] = 'Invalid bank reference format';
        }
        break;

      case PaymentMethod.jazzCash:
      case PaymentMethod.easyPaisa:
        if (accountNumber == null || accountNumber.trim().isEmpty) {
          errors['accountNumber'] =
              '${method == PaymentMethod.jazzCash ? 'JazzCash' : 'EasyPaisa'} account number is required';
        } else {
          final accountError = _validateMobilePaymentAccount(accountNumber);
          if (accountError != null) {
            errors['accountNumber'] = accountError;
          }
        }

        if (transactionId == null || transactionId.trim().isEmpty) {
          errors['transactionId'] =
              'Transaction reference/receipt number is required';
        } else if (!_isValidTransactionReference(transactionId)) {
          errors['transactionId'] = 'Invalid transaction reference format';
        }
        break;

      case PaymentMethod.credit:
        // Credit doesn't need additional validation at payment time
        break;
    }

    return errors;
  }

  /// Validate mobile payment account number
  static String? _validateMobilePaymentAccount(String accountNumber) {
    final account = accountNumber.trim().replaceAll(RegExp(r'[^\d]'), '');

    if (account.isEmpty) {
      return 'Account number cannot be empty';
    }

    if (account.length < 10 || account.length > 15) {
      return 'Account number must be between 10-15 digits';
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(account)) {
      return 'Account number must contain only digits';
    }

    // Additional validation: check for reasonable account format
    if (!_isValidAccountChecksum(account)) {
      return 'Invalid account number - please verify the number';
    }

    return null;
  }

  /// Simple checksum validation for account numbers
  static bool _isValidAccountChecksum(String account) {
    // Remove non-digit characters
    final digits = account.replaceAll(RegExp(r'[^\d]'), '');

    // Length must be valid
    if (digits.length < 10) return false;

    // Can't be all zeros
    if (digits.replaceAll('0', '').isEmpty) return false;

    // Can't have more than 3 consecutive same digits (basic sanity check)
    if (RegExp(r'(\d)\1{3,}').hasMatch(digits)) return false;

    return true;
  }

  /// Validate card transaction ID
  static bool _isValidCardTransactionId(String id) {
    final cleaned = id.trim().toUpperCase();
    // Card transaction IDs are typically 6-20 alphanumeric characters
    return RegExp(r'^[A-Z0-9]{6,20}$').hasMatch(cleaned) && cleaned.isNotEmpty;
  }

  /// Validate bank transfer reference
  static bool _isValidBankReference(String reference) {
    final cleaned = reference.trim().toUpperCase();
    // Bank references are typically 8-25 alphanumeric characters
    return RegExp(r'^[A-Z0-9]{8,25}$').hasMatch(cleaned) &&
        cleaned.isNotEmpty;
  }

  /// Validate transaction reference for mobile payments
  static bool _isValidTransactionReference(String reference) {
    final cleaned = reference.trim().toUpperCase();
    // Mobile transaction references are typically 8-20 alphanumeric
    return RegExp(r'^[A-Z0-9]{8,20}$').hasMatch(cleaned) &&
        cleaned.isNotEmpty;
  }

  /// Get user-friendly error message for payment method
  static String getMethodRequirements(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.cash:
        return 'Cash payment - no additional information needed';
      case PaymentMethod.card:
        return 'Enter card transaction ID/reference number';
      case PaymentMethod.bankTransfer:
        return 'Enter bank transfer reference/account number';
      case PaymentMethod.jazzCash:
        return 'Enter JazzCash account number and transaction reference';
      case PaymentMethod.easyPaisa:
        return 'Enter EasyPaisa account number and transaction reference';
      case PaymentMethod.credit:
        return 'Credit payment - will be recorded for later settlement';
    }
  }

  /// Check if payment method requires transaction ID
  static bool requiresTransactionId(PaymentMethod method) {
    return method != PaymentMethod.cash && method != PaymentMethod.credit;
  }

  /// Check if payment method requires account number
  static bool requiresAccountNumber(PaymentMethod method) {
    return method == PaymentMethod.jazzCash ||
        method == PaymentMethod.easyPaisa;
  }
}

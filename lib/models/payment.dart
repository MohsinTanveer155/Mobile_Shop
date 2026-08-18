enum PaymentMethod { cash, card, bankTransfer, credit, jazzCash, easyPaisa }

class Payment {
  final PaymentMethod method;
  final double amount;
  final DateTime timestamp;
  final String? transactionId; // For card/bank transfer reference
  final String? notes;
  final String? accountNumber; // For mobile payments (JazzCash/EasyPaisa)

  Payment({
    required this.method,
    required this.amount,
    required this.timestamp,
    this.transactionId,
    this.notes,
    this.accountNumber,
  });

  String get methodName {
    switch (method) {
      case PaymentMethod.cash:
        return 'Cash';
      case PaymentMethod.card:
        return 'Card';
      case PaymentMethod.bankTransfer:
        return 'Bank Transfer';
      case PaymentMethod.credit:
        return 'Credit';
      case PaymentMethod.jazzCash:
        return 'JazzCash';
      case PaymentMethod.easyPaisa:
        return 'EasyPaisa';
    }
  }

  // Convert Payment to JSON
  Map<String, dynamic> toJson() => {
    'method': method.toString().split('.').last,
    'amount': amount,
    'timestamp': timestamp.toIso8601String(),
    'transactionId': transactionId,
    'notes': notes,
    'accountNumber': accountNumber,
  };

  // Create Payment from JSON
  factory Payment.fromJson(Map<String, dynamic> json) {
    final methodString = json['method'] as String;
    final method = PaymentMethod.values.firstWhere(
      (e) => e.toString().split('.').last == methodString,
    );
    return Payment(
      method: method,
      amount: json['amount'] as double,
      timestamp: DateTime.parse(json['timestamp'] as String),
      transactionId: json['transactionId'] as String?,
      notes: json['notes'] as String?,
      accountNumber: json['accountNumber'] as String?,
    );
  }
}

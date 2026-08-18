import 'payment.dart';

class CustomerTransaction {
  final String id;
  final String customerId;
  final double amount;
  final DateTime date;
  final String type; // 'credit_sale' or 'repayment'
  final String? notes;
  final Payment? payment; // for repayments

  CustomerTransaction({
    required this.id,
    required this.customerId,
    required this.amount,
    required this.date,
    required this.type,
    this.notes,
    this.payment,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'customerId': customerId,
    'amount': amount,
    'date': date.toIso8601String(),
    'type': type,
    'notes': notes,
    'payment': payment?.toJson(),
  };

  factory CustomerTransaction.fromJson(Map<String, dynamic> json) => CustomerTransaction(
    id: json['id'] as String,
    customerId: json['customerId'] as String,
    amount: (json['amount'] as num).toDouble(),
    date: DateTime.parse(json['date'] as String),
    type: json['type'] as String,
    notes: json['notes'] as String?,
    payment: json['payment'] != null
        ? Payment.fromJson(json['payment'] as Map<String, dynamic>)
        : null,
  );
}


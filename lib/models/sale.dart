import 'payment.dart';

/// Domain model representing a single sale transaction.
/// Implements [Comparable] so collections can be sorted without
/// anonymous closures that break type inference in Dart 3.
class Sale implements Comparable<Sale> {
  final String productName;
  final int quantity;
  final double totalPrice;
  final double profit;
  final DateTime date;
  final Payment payment;
  final String? customerId;
  final double loyaltyPointsEarned;
  final double loyaltyPointsRedeemed;
  final double creditAmount;

  Sale({
    required this.productName,
    required this.quantity,
    required this.totalPrice,
    required this.profit,
    required this.date,
    required this.payment,
    this.customerId,
    this.loyaltyPointsEarned = 0.0,
    this.loyaltyPointsRedeemed = 0.0,
    this.creditAmount = 0.0,
  });

  // ==================== Comparable ====================

  /// Natural order: descending by date (most recent first).
  /// This prevents the "dynamic callback" type-mismatch error
  /// when calling `list.sort()` without an explicit comparator.
  @override
  int compareTo(Sale other) => other.date.compareTo(date);

  // ==================== Named Comparators (Clean Architecture) ====================

  /// Ascending by date (oldest first).
  static int byDateAsc(Sale a, Sale b) => a.date.compareTo(b.date);

  /// Descending by date (newest first).
  static int byDateDesc(Sale a, Sale b) => b.date.compareTo(a.date);

  /// Descending by total price.
  static int byTotalPriceDesc(Sale a, Sale b) => b.totalPrice.compareTo(a.totalPrice);

  /// Descending by profit.
  static int byProfitDesc(Sale a, Sale b) => b.profit.compareTo(a.profit);

  /// Descending by quantity sold.
  static int byQuantityDesc(Sale a, Sale b) => b.quantity.compareTo(a.quantity);

  // Convert Sale to JSON
  Map<String, dynamic> toJson() => {
    'productName': productName,
    'quantity': quantity,
    'totalPrice': totalPrice,
    'profit': profit,
    'date': date.toIso8601String(),
    'payment': payment.toJson(),
    'customerId': customerId,
    'loyaltyPointsEarned': loyaltyPointsEarned,
    'loyaltyPointsRedeemed': loyaltyPointsRedeemed,
    'creditAmount': creditAmount,
  };

  // Create Sale from JSON
  factory Sale.fromJson(Map<String, dynamic> json) => Sale(
    productName: json['productName'] as String,
    quantity: json['quantity'] as int,
    totalPrice: json['totalPrice'] as double,
    profit: (json['profit'] as num?)?.toDouble() ?? 0.0,
    date: DateTime.parse(json['date'] as String),
    payment: Payment.fromJson(json['payment'] as Map<String, dynamic>),
    customerId: json['customerId'] as String?,
    loyaltyPointsEarned: (json['loyaltyPointsEarned'] as num?)?.toDouble() ?? 0.0,
    loyaltyPointsRedeemed: (json['loyaltyPointsRedeemed'] as num?)?.toDouble() ?? 0.0,
    creditAmount: (json['creditAmount'] as num?)?.toDouble() ?? 0.0,
  );
}

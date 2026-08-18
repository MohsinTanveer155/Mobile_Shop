/// Represents a bundle of products sold together.
/// Example: Phone + Charger + Case at a discounted price.
class ProductBundle {
  final String id;
  String name;
  String? description;
  List<BundleItem> items;
  double discountPercent;
  DateTime createdAt;

  ProductBundle({
    required this.id,
    required this.name,
    this.description,
    required this.items,
    this.discountPercent = 0.0,
    required this.createdAt,
  });

  /// Calculate total price without discount
  double get subtotal => items.fold(
    0.0,
    (sum, item) => sum + (item.unitPrice * item.quantity),
  );

  /// Calculate discount amount
  double get discountAmount => subtotal * (discountPercent / 100);

  /// Calculate final price after discount
  double get finalPrice => subtotal - discountAmount;

  /// Total quantity of all items in bundle
  int get totalItemCount => items.fold(0, (sum, item) => sum + item.quantity);

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'items': items.map((i) => i.toJson()).toList(),
    'discountPercent': discountPercent,
    'createdAt': createdAt.toIso8601String(),
  };

  factory ProductBundle.fromJson(Map<String, dynamic> json) => ProductBundle(
    id: json['id'] as String,
    name: json['name'] as String,
    description: json['description'] as String?,
    items: (json['items'] as List<dynamic>)
        .map((e) => BundleItem.fromJson(e as Map<String, dynamic>))
        .toList(),
    discountPercent: (json['discountPercent'] as num?)?.toDouble() ?? 0.0,
    createdAt: DateTime.parse(json['createdAt'] as String),
  );
}

/// Individual item within a bundle.
class BundleItem {
  String productName;
  int quantity;
  double unitPrice;

  BundleItem({
    required this.productName,
    required this.quantity,
    required this.unitPrice,
  });

  double get totalPrice => unitPrice * quantity;

  Map<String, dynamic> toJson() => {
    'productName': productName,
    'quantity': quantity,
    'unitPrice': unitPrice,
  };

  factory BundleItem.fromJson(Map<String, dynamic> json) => BundleItem(
    productName: json['productName'] as String,
    quantity: json['quantity'] as int,
    unitPrice: (json['unitPrice'] as num).toDouble(),
  );
}


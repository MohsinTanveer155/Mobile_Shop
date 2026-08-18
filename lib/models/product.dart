import 'package:uuid/uuid.dart';

class Product {
  String id;
  String name;
  String? brand;
  String? model;
  double price;
  double? costPrice;
  int quantity;
  String? barcode;
  String? imageUrl;

  Product({
    String? id,
    required this.name,
    this.brand,
    this.model,
    required this.price,
    this.costPrice,
    required this.quantity,
    this.barcode,
    this.imageUrl,
  }) : id = id ?? const Uuid().v4();

  double get profitPerUnit {
    if (costPrice != null && costPrice! > 0) {
      return price - costPrice!;
    }
    // Fallback to 15% margin when cost is unknown
    return price * 0.15;
  }

  // Convert Product to JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'brand': brand,
        'model': model,
        'price': price,
        'costPrice': costPrice,
        'quantity': quantity,
        'barcode': barcode,
        'imageUrl': imageUrl,
      };

  // Create Product from JSON
  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] as String?,
        name: json['name'] as String,
        brand: json['brand'] as String?,
        model: json['model'] as String?,
        price: (json['price'] as num).toDouble(),
        costPrice: (json['costPrice'] as num?)?.toDouble(),
        quantity: json['quantity'] as int,
        barcode: json['barcode'] as String?,
        imageUrl: json['imageUrl'] as String?,
      );
}

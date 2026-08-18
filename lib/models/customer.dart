class Customer {
  final String id;
  String name;
  String phone;
  String? email;
  String? address;
  double loyaltyPoints;
  double creditBalance;
  DateTime createdAt;
  DateTime updatedAt;

  Customer({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    this.address,
    this.loyaltyPoints = 0.0,
    this.creditBalance = 0.0,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
    'email': email,
    'address': address,
    'loyaltyPoints': loyaltyPoints,
    'creditBalance': creditBalance,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json['id'] as String,
    name: json['name'] as String,
    phone: json['phone'] as String,
    email: json['email'] as String?,
    address: json['address'] as String?,
    loyaltyPoints: (json['loyaltyPoints'] as num?)?.toDouble() ?? 0.0,
    creditBalance: (json['creditBalance'] as num?)?.toDouble() ?? 0.0,
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );

  Customer copyWith({
    String? name,
    String? phone,
    String? email,
    String? address,
    double? loyaltyPoints,
    double? creditBalance,
    DateTime? updatedAt,
  }) {
    return Customer(
      id: id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      loyaltyPoints: loyaltyPoints ?? this.loyaltyPoints,
      creditBalance: creditBalance ?? this.creditBalance,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}


/// Represents a warranty record for a sold product.
/// Tracks warranty period, status, and claim history.
class WarrantyRecord {
  final String id;
  String productName;
  String? customerId;
  String? customerName;
  String? customerPhone;
  DateTime purchaseDate;
  int warrantyMonths;
  WarrantyStatus status;
  List<WarrantyClaim> claimHistory;
  DateTime createdAt;
  DateTime? updatedAt;

  WarrantyRecord({
    required this.id,
    required this.productName,
    this.customerId,
    this.customerName,
    this.customerPhone,
    required this.purchaseDate,
    this.warrantyMonths = 12,
    this.status = WarrantyStatus.active,
    List<WarrantyClaim>? claimHistory,
    required this.createdAt,
    this.updatedAt,
  }) : claimHistory = claimHistory ?? [];

  DateTime get expiryDate => DateTime(
    purchaseDate.year,
    purchaseDate.month + warrantyMonths,
    purchaseDate.day,
  );

  bool get isExpired => DateTime.now().isAfter(expiryDate);

  int get daysRemaining {
    final now = DateTime.now();
    if (isExpired) return 0;
    return expiryDate.difference(now).inDays;
  }

  String get statusDisplay {
    switch (status) {
      case WarrantyStatus.active:
        return isExpired ? 'Expired' : 'Active';
      case WarrantyStatus.claimed:
        return 'Claimed';
      case WarrantyStatus.void_:
        return 'Void';
    }
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'productName': productName,
    'customerId': customerId,
    'customerName': customerName,
    'customerPhone': customerPhone,
    'purchaseDate': purchaseDate.toIso8601String(),
    'warrantyMonths': warrantyMonths,
    'status': status.name,
    'claimHistory': claimHistory.map((c) => c.toJson()).toList(),
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };

  factory WarrantyRecord.fromJson(Map<String, dynamic> json) => WarrantyRecord(
    id: json['id'] as String,
    productName: json['productName'] as String,
    customerId: json['customerId'] as String?,
    customerName: json['customerName'] as String?,
    customerPhone: json['customerPhone'] as String?,
    purchaseDate: DateTime.parse(json['purchaseDate'] as String),
    warrantyMonths: json['warrantyMonths'] as int? ?? 12,
    status: WarrantyStatus.values.byName(json['status'] as String),
    claimHistory: (json['claimHistory'] as List<dynamic>?)
        ?.map((e) => WarrantyClaim.fromJson(e as Map<String, dynamic>))
        .toList() ?? [],
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt'] as String) : null,
  );
}

enum WarrantyStatus { active, claimed, void_ }

/// Represents a single warranty claim event.
class WarrantyClaim {
  final String id;
  final DateTime date;
  final String issue;
  String? resolution;
  double? cost;
  ClaimStatus claimStatus;

  WarrantyClaim({
    required this.id,
    required this.date,
    required this.issue,
    this.resolution,
    this.cost,
    this.claimStatus = ClaimStatus.pending,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date.toIso8601String(),
    'issue': issue,
    'resolution': resolution,
    'cost': cost,
    'claimStatus': claimStatus.name,
  };

  factory WarrantyClaim.fromJson(Map<String, dynamic> json) => WarrantyClaim(
    id: json['id'] as String,
    date: DateTime.parse(json['date'] as String),
    issue: json['issue'] as String,
    resolution: json['resolution'] as String?,
    cost: (json['cost'] as num?)?.toDouble(),
    claimStatus: ClaimStatus.values.byName(json['claimStatus'] as String),
  );
}

enum ClaimStatus { pending, approved, rejected, resolved }


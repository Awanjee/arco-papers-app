class TransactionLineItem {
  final String id;
  final String? productCode;
  final String? description;
  final double? quantity;
  final double? unitPrice;
  final double? amount;
  final double? confidence;
  final String? notes;

  TransactionLineItem({
    required this.id,
    this.productCode,
    this.description,
    this.quantity,
    this.unitPrice,
    this.amount,
    this.confidence,
    this.notes,
  });

  factory TransactionLineItem.fromJson(Map<String, dynamic> j) =>
      TransactionLineItem(
        id: j['id'] as String,
        productCode: j['product_code'] as String?,
        description: j['description'] as String?,
        quantity: (j['quantity'] as num?)?.toDouble(),
        unitPrice: (j['unit_price'] as num?)?.toDouble(),
        amount: (j['amount'] as num?)?.toDouble(),
        confidence: (j['confidence'] as num?)?.toDouble(),
        notes: j['notes'] as String?,
      );
}

class TransactionDetail {
  final String id;
  final String? transactionDate;
  final String? documentType;
  final String? transactionType;
  final double? totalAmount;
  final String? notes;
  final String? partyNameRoman;
  final String? partyNameUrdu;
  final List<TransactionLineItem> lineItems;

  TransactionDetail({
    required this.id,
    this.transactionDate,
    this.documentType,
    this.transactionType,
    this.totalAmount,
    this.notes,
    this.partyNameRoman,
    this.partyNameUrdu,
    required this.lineItems,
  });

  factory TransactionDetail.fromJson(Map<String, dynamic> j) {
    final party = j['parties'] as Map<String, dynamic>?;
    final items = (j['transaction_line_items'] as List<dynamic>? ?? [])
        .map((e) => TransactionLineItem.fromJson(e as Map<String, dynamic>))
        .toList();
    return TransactionDetail(
      id: j['id'] as String,
      transactionDate: j['transaction_date'] as String?,
      documentType: j['document_type'] as String?,
      transactionType: j['transaction_type'] as String?,
      totalAmount: (j['total_amount'] as num?)?.toDouble(),
      notes: j['notes'] as String?,
      partyNameRoman: party?['name_roman'] as String?,
      partyNameUrdu: party?['name_urdu'] as String?,
      lineItems: items,
    );
  }
}

class TransactionSummary {
  final String id;
  final String? transactionDate;
  final String? documentType;
  final String? transactionType;
  final double? totalAmount;
  final String? notes;
  final String? partyNameRoman;
  final String? partyNameUrdu;
  final String? createdAt;

  TransactionSummary({
    required this.id,
    this.transactionDate,
    this.documentType,
    this.transactionType,
    this.totalAmount,
    this.notes,
    this.partyNameRoman,
    this.partyNameUrdu,
    this.createdAt,
  });

  factory TransactionSummary.fromJson(Map<String, dynamic> j) {
    final party = j['parties'] as Map<String, dynamic>?;
    return TransactionSummary(
      id: j['id'] as String,
      transactionDate: j['transaction_date'] as String?,
      documentType: j['document_type'] as String?,
      transactionType: j['transaction_type'] as String?,
      totalAmount: (j['total_amount'] as num?)?.toDouble(),
      notes: j['notes'] as String?,
      partyNameRoman: party?['name_roman'] as String?,
      partyNameUrdu: party?['name_urdu'] as String?,
      createdAt: j['created_at'] as String?,
    );
  }
}

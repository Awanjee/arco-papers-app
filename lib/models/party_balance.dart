class PartyBalance {
  final String partyId;
  final String? nameRoman;
  final String? nameUrdu;
  final double balance;
  final double totalSales;
  final double totalPayments;
  final int transactionCount;
  final String? lastTransactionDate;

  PartyBalance({
    required this.partyId,
    this.nameRoman,
    this.nameUrdu,
    required this.balance,
    required this.totalSales,
    required this.totalPayments,
    required this.transactionCount,
    this.lastTransactionDate,
  });

  factory PartyBalance.fromJson(Map<String, dynamic> j) => PartyBalance(
        partyId: j['party_id'] as String,
        nameRoman: j['name_roman'] as String?,
        nameUrdu: j['name_urdu'] as String?,
        balance: (j['balance'] as num?)?.toDouble() ?? 0.0,
        totalSales: (j['total_sales'] as num?)?.toDouble() ?? 0.0,
        totalPayments: (j['total_payments'] as num?)?.toDouble() ?? 0.0,
        transactionCount: (j['transaction_count'] as num?)?.toInt() ?? 0,
        lastTransactionDate: j['last_transaction_date'] as String?,
      );
}

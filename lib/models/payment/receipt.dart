class Receipt {
  Receipt({
    required this.receiptID,
    required this.customerUID,
    required this.timestamp,
    required this.exchangeRate,
    required this.totalCrypto,
    this.localCurrency = '\$',
    this.cryptoCoinSymbol = 'btc',
  });

  final String receiptID;
  final String customerUID;
  final int timestamp;
  final String localCurrency;
  final String cryptoCoinSymbol;
  final double exchangeRate;
  final double totalCrypto;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'receipt_id': receiptID,
      'customer_uid': customerUID,
      'timestamp': timestamp,
      'local_currency': localCurrency,
      'crypto_coin_symbol': cryptoCoinSymbol,
      'exchange_rate': exchangeRate,
      'total_crypto': totalCrypto,
    };
  }

  // ignore: sort_constructors_first
  factory Receipt.fromMap(Map<String, dynamic> map) {
    return Receipt(
      receiptID: map['receipt_id'] ?? '',
      customerUID: map['customer_uid'] ?? '',
      timestamp: map['timestamp'] ?? 0,
      localCurrency: map['local_currency'] ?? '\$',
      cryptoCoinSymbol: map['crypto_coin_symbol'] ?? 'btc',
      exchangeRate: map['exchange_rate'] ?? 0.0,
      totalCrypto: map['total_crypto'] ?? 0.0,
    );
  }
}

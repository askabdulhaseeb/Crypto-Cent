import 'package:cloud_firestore/cloud_firestore.dart';

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
  factory Receipt.fromMap(DocumentSnapshot<Map<String, dynamic>> doc) {
    return Receipt(
      receiptID: doc.data()?['receipt_id'] ?? '',
      customerUID: doc.data()?['customer_uid'] ?? '',
      timestamp: doc.data()?['timestamp'] ?? 0,
      localCurrency: doc.data()?['local_currency'] ?? '\$',
      cryptoCoinSymbol: doc.data()?['crypto_coin_symbol'] ?? 'btc',
      exchangeRate: doc.data()?['exchange_rate'] ?? 0.0,
      totalCrypto: doc.data()?['total_crypto'] ?? 0.0,
    );
  }
}

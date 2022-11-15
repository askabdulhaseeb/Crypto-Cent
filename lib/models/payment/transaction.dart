// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../enum/order_status_enum.dart';

class Transaction {
  final String transactionID;
  final String orderID;
  final String buyerID;
  final String sellerID;
  final int timeStamp;
  final double exchangeRate;
  final String cryptoSymbol;
  final double cryptoPrice;
  // ignore: always_specify_types
  OrderStatusEnum status;
  Transaction({
    required this.transactionID,
    required this.orderID,
    required this.buyerID,
    required this.sellerID,
    required this.timeStamp,
    required this.exchangeRate,
    required this.cryptoSymbol,
    required this.cryptoPrice,
    this.status = OrderStatusEnum.pending,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'transactionID': transactionID,
      'orderID': orderID,
      'buyerID': buyerID,
      'sellerID': sellerID,
      'status': status.value,
      'timeStamp': timeStamp,
      'exchangeRate': exchangeRate,
      'cryptoSymbol': cryptoSymbol,
      'cryptoPrice': cryptoPrice,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      transactionID: map['transactionID'] as String,
      orderID: map['orderID'] as String,
      buyerID: map['buyerID'] as String,
      sellerID: map['sellerID'] as String,
      status: OrderStatusConvetion().stringToEnum(map['status']),
      timeStamp: map['timeStamp'] as int,
      exchangeRate: map['exchangeRate'] as double,
      cryptoSymbol: map['cryptoSymbol'] as String,
      cryptoPrice: map['cryptoPrice'] as double,
    );
  }
}

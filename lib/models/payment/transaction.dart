// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../enum/order_status_enum.dart';
import 'orderd_product.dart';

class Transactions {
  Transactions({
    required this.transactionID,
    required this.products,
    required this.orderID,
    required this.customerUID,
    required this.sellerUID,
    required this.timeStamp,
    required this.exchangeRate,
    required this.cryptoSymbol,
    required this.totalCryptoPrice,
    this.status = OrderStatusEnum.pending,
  });

  final String transactionID;
  final List<OrderdProduct> products;
  final String orderID;
  final String customerUID;
  final String sellerUID;
  final int timeStamp;
  final double exchangeRate;
  final String cryptoSymbol;
  final double totalCryptoPrice;
  OrderStatusEnum<String> status;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'transaction_id': transactionID,
      'products': products.map((OrderdProduct x) => x.toMap()).toList(),
      'order_id': orderID,
      'customer_uid': customerUID,
      'seller_uid': sellerUID,
      'status': status.value,
      'timestamp': timeStamp,
      'exchange_rate': exchangeRate,
      'crypto_symbol': cryptoSymbol,
      'total_local_price': totalCryptoPrice,
    };
  }

  factory Transactions.fromMap(Map<String, dynamic> map) {
    return Transactions(
      transactionID: map['transaction_id'] as String,
      products: map['products'] == null
          ? <OrderdProduct>[]
          : List<OrderdProduct>.from(
              (map['products'] as List<int>).map<OrderdProduct>(
                (int x) => OrderdProduct.fromMap(x as Map<String, dynamic>),
              ),
            ),
      orderID: map['order_id'] as String,
      customerUID: map['customer_uid'] as String,
      sellerUID: map['seller_uid'] ?? '',
      status: OrderStatusConvetion().stringToEnum(map['status']),
      timeStamp: map['timestamp'] as int,
      exchangeRate: map['exchange_rate'] as double,
      cryptoSymbol: map['crypto_symbol'] as String,
      totalCryptoPrice: map['total_local_price'] as double,
    );
  }
}

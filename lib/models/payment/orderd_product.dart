import '../../enum/order_status_enum.dart';

class OrderdProduct {
  OrderdProduct({
    required this.pid,
    required this.cryptoPrice,
    required this.localPrice,
    required this.quantity,
    this.status = OrderStatusEnum.pending,
    this.localCurrency = '\$',
    this.cryptoCoinSymbol = 'btc',
  });

  final String pid;
  int quantity;
  final String localCurrency;
  final String cryptoCoinSymbol;
  final double localPrice;
  final double cryptoPrice;
  OrderStatusEnum status;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pid': pid,
      'quantity': quantity,
      'local_currency': localCurrency,
      'crypto_coin_symbol': cryptoCoinSymbol,
      'local_price': localPrice,
      'crypto_price': cryptoPrice,
    };
  }

  // ignore: sort_constructors_first
  factory OrderdProduct.fromMap(Map<String, dynamic> map) {
    return OrderdProduct(
      pid: map['pid'] ?? '',
      quantity: map['quantity'] ?? 0,
      localCurrency: map['local_currency'] ?? '\$',
      cryptoCoinSymbol: map['crypto_coin_symbol'] ?? 'btc',
      localPrice: map['local_price'] ?? 0.0,
      cryptoPrice: map['crypto_price'] ?? 0.0,
    );
  }
}

import '../../enum/order_status_enum.dart';

class OrderdProduct {
  OrderdProduct({
    required this.pid,
    required this.cryptoPrice,
    required this.exchangeRate,
    required this.quantity,
    this.status = OrderStatusEnum.pending,
    this.localCurrency = '\$',
    this.cryptoCoinSymbol = 'btc',
  });

  final String pid;
  int quantity;
  final String localCurrency;
  final String cryptoCoinSymbol;
  final double exchangeRate;
  final double cryptoPrice;
  OrderStatusEnum status;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pid': pid,
      'quantity': quantity,
      'local_currency': localCurrency,
      'crypto_coin_symbol': cryptoCoinSymbol,
      'exchange_rate': exchangeRate,
      'crypto_price': cryptoPrice,
      'status': status.value,
    };
  }

  // ignore: sort_constructors_first
  factory OrderdProduct.fromMap(Map<String, dynamic> map) {
    return OrderdProduct(
      pid: map['pid'] ?? '',
      quantity: map['quantity'] ?? 0,
      localCurrency: map['local_currency'] ?? '\$',
      cryptoCoinSymbol: map['crypto_coin_symbol'] ?? 'btc',
      exchangeRate: map['exchange_rate'] ?? 0.0,
      cryptoPrice: map['crypto_price'] ?? 0.0,
      status: OrderStatusConvetion().stringToEnum(map['status']),
    );
  }
}

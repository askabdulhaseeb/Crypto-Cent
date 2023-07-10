
import '../../enum/order_status_enum.dart';

class OrderdProduct {
  OrderdProduct({
    required this.pid,
    required this.sellerID,
    required this.amount,
    required this.quantity,
    this.status = OrderStatusEnum.pending,
    this.localCurrency = 'pkr',
 
  });

  final String pid;
  final String sellerID;
  int quantity;
  final String localCurrency;

  double amount;
  OrderStatusEnum<String> status;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pid': pid,
      'seller_id': sellerID,
      'quantity': quantity,
      'local_currency': localCurrency,
 
      'local_amount': amount,
      'status': status.value,
    };
  }

  Map<String, dynamic> updateStatus() {
    return <String, dynamic>{
      'status': status.value,
    };
  }

  // ignore: sort_constructors_first
  factory OrderdProduct.fromMap(Map<String, dynamic> map) {
    return OrderdProduct(
      pid: map['pid'] ?? '',
      sellerID: map['seller_id'] ?? '',
      quantity: map['quantity'] ?? 0,
      localCurrency: map['local_currency'] ?? 'pkr',
     
      amount: double.parse(map['local_amount']?.toString() ?? '0.0'),
      status: OrderStatusConvetion().stringToEnum(map['status']),
    );
  }
}

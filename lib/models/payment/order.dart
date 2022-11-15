import '../../enum/order_status_enum.dart';
import 'orderd_product.dart';

class Order {
  Order({
    required this.orderID,
    required this.receiptID,
    required this.sellerUID,
    required this.customerUID,
    required this.products,
    this.status = OrderStatusEnum.pending,
  });

  final String orderID;
  final String receiptID;
  final String sellerUID;
  final String customerUID;
  final List<OrderdProduct> products;
  // ignore: always_specify_types
  OrderStatusEnum status;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'order_id': orderID,
      'receipt_id': receiptID,
      'seller_uid': sellerUID,
      'customer_uid': customerUID,
      'products': products.map((OrderdProduct x) => x.toMap()).toList(),
      'status': status.value,
    };
  }

  // ignore: sort_constructors_first
  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      orderID: map['order_id'] ?? '',
      receiptID: map['receipt_id'] ?? '',
      sellerUID: map['seller_uid'] ?? '',
      customerUID: map['customer_uid'] ?? '',
      products: map['products'] == null
          ? <OrderdProduct>[]
          : List<OrderdProduct>.from(
              (map['products'] as List<int>).map<OrderdProduct>(
                (int x) => OrderdProduct.fromMap(x as Map<String, dynamic>),
              ),
            ),
      status: OrderStatusConvetion().stringToEnum(map['status']),
    );
  }
}

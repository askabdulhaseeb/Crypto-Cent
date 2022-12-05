import 'package:cloud_firestore/cloud_firestore.dart';

import '../../enum/order_status_enum.dart';
import 'orderd_product.dart';

class Order {
  Order({
    required this.orderID,
    required this.receiptID,
    required this.sellerUID,
    required this.customerUID,
    required this.products,
    required this.timestamp,
    this.status = OrderStatusEnum.pending,
  });

  final String orderID;
  final String receiptID;
  final String sellerUID;
  final String customerUID;
  final int timestamp;
  final List<OrderdProduct> products;
  OrderStatusEnum<String> status;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'order_id': orderID,
      'receipt_id': receiptID,
      'seller_uid': sellerUID,
      'customer_uid': customerUID,
      'timestamp': timestamp,
      'products': products.map((OrderdProduct x) => x.toMap()).toList(),
      'status': status.value,
    };
  }

  Map<String, dynamic> updateStatus() {
    return <String, dynamic>{
      'products': products.map((OrderdProduct x) => x.toMap()).toList(),
    };
  }

  // ignore: sort_constructors_first
  factory Order.fromMap(DocumentSnapshot<Map<String, dynamic>> doc) {
    return Order(
      orderID: doc.data()?['order_id'] ?? '',
      receiptID: doc.data()?['receipt_id'] ?? '',
      sellerUID: doc.data()?['seller_uid'] ?? '',
      customerUID: doc.data()?['customer_uid'] ?? '',
      timestamp: doc.data()?['timestamp'] ?? 0,
      products: doc.data()?['products'] == null
          ? <OrderdProduct>[]
          : List<OrderdProduct>.from(
              (doc.data()?['products'] as List<dynamic>).map<OrderdProduct>(
                (dynamic x) => OrderdProduct.fromMap(x as Map<String, dynamic>),
              ),
            ),
      status: OrderStatusConvetion().stringToEnum(doc.data()?['status']),
    );
  }
}

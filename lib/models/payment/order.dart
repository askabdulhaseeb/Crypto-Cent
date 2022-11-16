import 'package:cloud_firestore/cloud_firestore.dart';

import '../../enum/order_status_enum.dart';
import 'orderd_product.dart';

class Order {
  Order({
    required this.orderID,
    required this.receiptID,
    required this.customerUID,
    required this.products,
    this.status = OrderStatusEnum.pending,
  });

  final String orderID;
  final String receiptID;

  final String customerUID;
  final List<OrderdProduct> products;
  OrderStatusEnum<String> status;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'order_id': orderID,
      'receipt_id': receiptID,
      'customer_uid': customerUID,
      'products': products.map((OrderdProduct x) => x.toMap()).toList(),
      'status': status.value,
    };
  }

  // ignore: sort_constructors_first
  factory Order.fromMap(DocumentSnapshot<Map<String, dynamic>> doc) {
    return Order(
      orderID: doc.data()?['order_id'] ?? '',
      receiptID: doc.data()?['receipt_id'] ?? '',
      customerUID: doc.data()?['customer_uid'] ?? '',
      products: doc.data()?['products'] == null
          ? <OrderdProduct>[]
          : List<OrderdProduct>.from(
              (doc.data()?['products'] as List<int>).map<OrderdProduct>(
                (int x) => OrderdProduct.fromMap(x as Map<String, dynamic>),
              ),
            ),
      status: OrderStatusConvetion().stringToEnum(doc.data()?['status']),
    );
  }
}

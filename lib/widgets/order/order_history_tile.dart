import 'package:flutter/material.dart';

import '../../enum/order_status_enum.dart';
import '../../function/time_date_function.dart';
import '../../models/payment/order.dart';
import '../../utilities/app_images.dart';
import '../custom_widgets/cutom_text.dart';


class OrderHistoryTile extends StatelessWidget {
  const OrderHistoryTile({required this.order, Key? key}) : super(key: key);
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xfff6f7f9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(6),
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: order.status == OrderStatusEnum.cancel
                ? Image(image: AssetImage(AppImages.ellipsecancel))
                : Image(image: AssetImage(AppImages.ellipse)),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ForText(
                  name: order.status.value,
                  bold: true,
                  size: 16,
                ),
                Text(
                  'BTC :${order.products[0].exchangeRate}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                ForText(
                  name: 'Item: ${order.products.length}',
                  size: 14,
                ),
              ],
            ),
          ),
          ForText(name: TimeStamp.timeInWords(order.timestamp)),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}

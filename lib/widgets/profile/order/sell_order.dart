import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../database/payment/order_api.dart';
import '../../../enum/order_status_enum.dart';
import '../../../models/payment/order.dart';
import '../../../models/payment/orderd_product.dart';
import '../../../models/product/product_model.dart';
import '../../../providers/payment/payment_provider.dart';
import '../../../providers/provider.dart';
import '../../custom_widgets/custom_elevated_button.dart';
import '../../custom_widgets/custom_network_image.dart';
import 'buy_history_tile.dart';

class SellOrder extends StatelessWidget {
  const SellOrder({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<PaymentProvider, ProductProvider>(builder:
          (BuildContext context, PaymentProvider orderPro,
              ProductProvider productPro, Widget? snapshot) {
        return ListView.builder(
          itemCount: orderPro.sellProducts.length,
          itemBuilder: (BuildContext context, int index) {
            Product product =
                productPro.product(orderPro.sellProducts[index].pid);
            Order item = orderPro.sellingOrder[index];
            //final Order item = orderPro.order[index];
            return ListTile(
              leading: SizedBox(
                width: 50,
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: CustomNetworkImage(
                    imageURL: product.prodURL[0].url,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              title: Text(product.productname),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    ' \$ : ${orderPro.sellProducts[index].localAmount.toString()} - Btc : ${(orderPro.sellProducts[index].localAmount / orderPro.sellProducts[index].exchangeRate).toStringAsFixed(8)}',
                  ),
                  Row(
                    children: <Widget>[
                      if (orderPro.sellProducts[index].status ==
                              OrderStatusEnum.pending ||
                          orderPro.sellProducts[index].status ==
                              OrderStatusEnum.offer)
                        Expanded(
                          child: CustomElevatedButton(
                            title: 'Cancel',
                            bgColor: Colors.red,
                            onTap: () async {
                              orderPro.sellProducts[index].status =
                                  OrderStatusEnum.cancel;
                              //await OrderApi().updateStatus(item);
                            },
                          ),
                        ),
                      if (orderPro.sellProducts[index].status ==
                          OrderStatusEnum.pending)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: CustomElevatedButton(
                              title: 'Deliver',
                              bgColor: Colors.green,
                              onTap: () async {
                                orderPro.sellProducts[index].status =
                                    OrderStatusEnum.inProgress;
                                await OrderApi().updateStatus(item);
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              trailing: Column(
                children: <Widget>[
                  const Text('Status'),
                  Text(
                    orderPro.sellProducts[index].status.name,
                    style: TextStyle(
                      color: orderPro.sellProducts[index].status ==
                              OrderStatusEnum.completed
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../database/order_api.dart';
import '../../../enum/order_status_enum.dart';
import '../../../models/my_order.dart';
import '../../../models/product/product_model.dart';
import '../../../providers/payment_provider.dart';
import '../../../providers/product_provider.dart';
import '../../custom_widgets/custom_elevated_button.dart';
import '../../custom_widgets/custom_network_image.dart';

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
            MyOrder item = orderPro.sellingOrder[index];
            //final MyOrder item = orderPro.order[index];
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
                    ' \pkr : ${orderPro.sellProducts[index].amount} ',
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
                            bgColor: Colors.red[200],
                            onTap: () async {
                              await HapticFeedback.heavyImpact();
                              orderPro.sellProducts[index].status =
                                  OrderStatusEnum.cancel;
                              await OrderApi().updateStatus(item);
                              // Provider.of<AppProvider>(context, listen: false)
                              //     .onTabTapped(4);
                              Navigator.pop(context);
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
                              onTap: () async {
                                await HapticFeedback.heavyImpact();
                                orderPro.sellProducts[index].status =
                                    OrderStatusEnum.inProgress;
                                await OrderApi().updateStatus(item);
                                // Provider.of<AppProvider>(context, listen: false)
                                //     .onTabTapped(4);
                                Navigator.pop(context);
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

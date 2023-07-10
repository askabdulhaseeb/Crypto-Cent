import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../database/order_api.dart';
import '../../../enum/order_status_enum.dart';
import '../../../models/my_order.dart';
import '../../../models/payment/orderd_product.dart';
import '../../../models/product/product_model.dart';
import '../../../providers/product_provider.dart';
import '../../custom_widgets/custom_elevated_button.dart';
import '../../custom_widgets/custom_network_image.dart';


class OrderHistoryTile extends StatefulWidget {
  const OrderHistoryTile({required this.item, super.key});
  final MyOrder item;

  @override
  State<OrderHistoryTile> createState() => _OrderHistoryTileState();
}

class _OrderHistoryTileState extends State<OrderHistoryTile> {
  bool exPanded = false;
  void shrink() {
    setState(() {
      exPanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      key: UniqueKey(),
      initiallyExpanded: exPanded,
      title: Text('Status ${widget.item.status.value}'),
      subtitle: Text(widget.item.orderID,
          maxLines: 1, overflow: TextOverflow.ellipsis),
      children: widget.item.products
          .map((OrderdProduct e) => Consumer<ProductProvider>(
                  builder: (BuildContext context, ProductProvider productPro,
                      Widget? snapshot) {
                Product product = productPro.product(e.pid);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
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
                          ' pkr :${e.amount}',
                        ),
                        Row(
                          children: <Widget>[
                            if (e.status == OrderStatusEnum.pending ||
                                e.status == OrderStatusEnum.offer)
                              Expanded(
                                child: CustomElevatedButton(
                                  title: 'Cancel',
                                  bgColor: Colors.red[200],
                                  onTap: () async {
                                    await HapticFeedback.heavyImpact();
                                    shrink();
                                    e.status = OrderStatusEnum.cancel;
                                    await OrderApi().updateStatus(widget.item);
                                  },
                                ),
                              ),
                            if (e.status == OrderStatusEnum.pending ||
                                e.status == OrderStatusEnum.inProgress)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: CustomElevatedButton(
                                    title: 'Done',
                                    onTap: () async {
                                      await HapticFeedback.heavyImpact();
                                      shrink();
                                      e.status = OrderStatusEnum.completed;
                                     
                                      await OrderApi()
                                          .updateStatus(widget.item);
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
                          e.status.name,
                          style: TextStyle(
                            color: e.status == OrderStatusEnum.completed
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }))
          .toList(),
    );
  }



}

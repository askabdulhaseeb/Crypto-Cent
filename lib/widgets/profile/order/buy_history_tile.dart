import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../database/payment/order_api.dart';
import '../../../enum/order_status_enum.dart';
import '../../../models/payment/order.dart';
import '../../../models/payment/orderd_product.dart';
import '../../../models/product/product_model.dart';
import '../../../providers/crypto_wallet/wallet_provider.dart';
import '../../../providers/product_provider.dart';
import '../../../providers/rating_provider.dart';
import '../../custom_widgets/custom_elevated_button.dart';
import '../../custom_widgets/custom_network_image.dart';
import '../../custom_widgets/custom_textformfield.dart';

class OrderHistoryTile extends StatefulWidget {
  const OrderHistoryTile({required this.item, super.key});
  final Order item;

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
          .map((OrderdProduct e) => Consumer2<ProductProvider, WalletProvider>(
                  builder: (BuildContext context, ProductProvider productPro,
                      WalletProvider walletPro, Widget? snapshot) {
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
                          ' \$ :${e.localAmount.toString()} - Btc :${(e.localAmount / e.exchangeRate).toStringAsFixed(8)}',
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
                                      shrink();
                                      e.status = OrderStatusEnum.completed;
                                      alertBox(context, product, e);
                                      // bool temp =
                                      //     walletPro.getSellerWallet(e.sellerID);
                                      // if (temp) {
                                      //   print(walletPro
                                      //       .sellerWallet!.coinsWallet[0].wallet);

                                      //   String walletIDD = Encryption()
                                      //       .userDecrypt(
                                      //           walletPro.sellerWallet!
                                      //               .coinsWallet[0].wallet,
                                      //           e.sellerID);
                                      //   print(walletIDD);
                                      // }
                                      //print(e.sellerID);
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

  Future<dynamic> alertBox(
    BuildContext context,
    Product product,
    OrderdProduct orderded,
  ) async {
    showDialog(
        useSafeArea: true,
        context: context,
        builder: (BuildContext context) {
          return Consumer<RatingProvider>(
              builder: (BuildContext context, RatingProvider ratingPro, _) {
            //return const CustomReviewDialogBox();
            return AlertDialog(
              title: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                          height: 30,
                          width: 30,
                          child: ClipRRect(
                            child: CustomNetworkImage(
                              imageURL: product.prodURL[0].url,
                              fit: BoxFit.fill,
                            ),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(product.productname),
                    ],
                  ),
                  ratingBar(ratingPro),
                ],
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              content: CustomTextFormField(
                controller: ratingPro.ratingComment,
                hint: 'Comment',
                maxLength: 500,
                maxLines: 5,
              ),
              // ignore: always_specify_types
              actions: [
                CustomElevatedButton(
                    title: 'Done',
                    onTap: () async {
                      bool temp = await ratingPro.uploadRating(orderded);
                      if (temp) {
                         Navigator.pop(context);
                      }
                    }),
              ],
            );
          });
        });
  }

  RatingBar ratingBar(RatingProvider ratingPro) {
    return RatingBar.builder(
      initialRating: 3,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (BuildContext context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (double rating) {
        ratingPro.rating = rating;
      },
    );
  }
}

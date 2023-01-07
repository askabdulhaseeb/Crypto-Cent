import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product/product_model.dart';
import '../../providers/cart_provider.dart';
import '../custom_widgets/custom_elevated_button.dart';
import '../custom_widgets/custom_network_image.dart';
import '../custom_widgets/cutom_text.dart';

class AddToCartWidget extends StatefulWidget {
  const AddToCartWidget({required this.product,required this.buttonText, Key? key}) : super(key: key);
  final Product product;
  final String buttonText;

  @override
  State<AddToCartWidget> createState() => _AddToCartWidgetState();
}

class _AddToCartWidgetState extends State<AddToCartWidget> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    CartProvider cartPro = Provider.of<CartProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: StatefulBuilder(builder: (
        BuildContext context,
        Function setState,
      ) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: 120,
                    width: 120,
                    child: CustomNetworkImage(
                        imageURL: widget.product.prodURL[0].url),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.product.productname.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '\$${widget.product.amount}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        ForText(
                          name:
                              'Availavle Quantity: ${widget.product.quantity}',
                          bold: true,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  onPressed: quantity < 2
                      ? null
                      : () {
                          setState(() {
                            quantity--;
                          });
                        },
                  icon: Icon(
                    Icons.remove_circle_outline,
                    size: 24,
                    color: quantity < 2 ? Colors.grey : Colors.red,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).secondaryHeaderColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      quantity.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: quantity >= int.parse(widget.product.quantity)
                      ? null
                      : () {
                          setState(() {
                            quantity++;
                          });
                        },
                  icon: Icon(
                    Icons.add_circle_outline,
                    size: 24,
                    color: quantity >= int.parse(widget.product.quantity)
                        ? Colors.grey
                        : Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            (cartPro.checkExit(widget.product))
                ? const Icon(
                    Icons.done,
                    color: Colors.green,
                    size: 29,
                  )
                : CustomElevatedButton(
                    title: widget.buttonText,
                    onTap: () {
                      cartPro.addtocart(widget.product, quantity);
                      Navigator.of(context).pop();
                    }),
            const SizedBox(height: 10),
          ],
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/product_model.dart';

class LatestScreenExtend extends StatelessWidget {
  const LatestScreenExtend({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    //feedScreendatabase feedattribute = Provider.of<feedScreendatabase>(context);
    //final favproviderScreens = Provider.of<favprovider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 15),
      child: InkWell(
        onTap: () {
          // Navigator.of(context)
          //     .pushNamed('/productdetail', arguments: widget.id);
        },
        child: Container(
          height: 180,
          width: 170,
          decoration: BoxDecoration(
              color: const Color(0xffF6F7F9),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(1, 0),
                  blurRadius: 4,
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Image(
                    image: NetworkImage(product.imageurl),
                  ),
                ),
                Text(
                  product.productname,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.lato(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${product.amount}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_border_rounded,
                            color: Colors.black,
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

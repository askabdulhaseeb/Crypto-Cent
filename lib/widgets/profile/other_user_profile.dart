import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/provider.dart';
import '../../models/app_user/app_user.dart';
import '../../models/product/product_model.dart';
import '../custom_widgets/custom_rating_star.dart';
import '../custom_widgets/cutom_text.dart';
import '../product/extend_product_tile.dart';
import 'profile_header.dart';

class OtherUserProfile extends StatelessWidget {
  const OtherUserProfile({required this.appUser, super.key});
  final AppUser appUser;
  @override
  Widget build(BuildContext context) {
    ProductProvider prouctPro = Provider.of<ProductProvider>(context);
    List<Product> products = <Product>[];
    products = prouctPro.productByUID(appUser.uid);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        title: Text(appUser.name!),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 200,
              width: double.infinity,
              color: Theme.of(context).secondaryHeaderColor,
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 64,
                    backgroundImage: appUser.imageURL!.isEmpty
                        ? null
                        : NetworkImage(appUser.imageURL!),
                    child: appUser.imageURL!.isEmpty
                        ? const Icon(Icons.person, size: 80, color: Colors.grey)
                        : null,
                  ),
                  const SizedBox(height: 10),
                  Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomRatingBar(
                        itemSize: 24,
                        initialRating: 5,
                        onRatingUpdate: (_) {},
                      ),
                      const ForText(
                        name: '(0 reviews)',
                        size: 13,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            tilewidget(context: context, text: 'Reviews', icon: Icons.reviews),
            const SizedBox(height: 30),
            GridView.count(
              childAspectRatio: 200 / 330,
              mainAxisSpacing: 8,
              crossAxisSpacing: 4,
              crossAxisCount: 2,
              shrinkWrap: true,
              primary: false,
              children: List<Widget>.generate(products.length, (int index) {
                return ExtendProductTile(product: products[index]);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget tilewidget({BuildContext? context, String? text, IconData? icon}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xffF6F7F9),
      ),
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 25),
      child: ListTile(
        leading: Icon(
          icon!,
          color: Theme.of(context!).primaryColor,
        ),
        title: ForText(
          name: text!,
          bold: true,
        ),
      ),
    );
  }
}

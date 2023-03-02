import 'package:flutter/material.dart';
import 'package:crypto_cent/widgets/custom_widgets/web/header_text_widget.dart';
import '../screens/cart_screen/cart_screen.dart';
import '../screens/main_screen/main_screen.dart';
import '../utilities/app_images.dart';
import '../widgets/custom_widgets/cutom_text.dart';

class WebAppBar {
  static String txt='HOME';
   AppBar  webAppBar (BuildContext context){
   return AppBar(
        leading: const SizedBox(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 200,
              height: 40,
              child: Image.asset(AppImages.logo),
            ),
            const Spacer(),
            HeaderTextWidget(
              name: 'HOME',
              image: AppImages.homeUnselected,
              color: txt=='HOME'?const Color(0xffFFA44B): Colors.black,
              ontap: () {
                txt='HOME';
                Navigator.of(context).pushNamedAndRemoveUntil(MainScreen.routeName, (route) => false);
              },
            ),
            HeaderTextWidget(
              name: 'WISHLIST',
              image: AppImages.fvrtIcon,
              color: txt=='WISHLIST'?const Color(0xffFFA44B): Colors.black,
              ontap: () {
                txt='WISHLIST';
              },
            ),
            HeaderTextWidget(
                name: 'CART',
                image: AppImages.shoppingcartIcon,
                ontap: () {
                  
                  txt='CART';
                  Navigator.of(context).pushNamedAndRemoveUntil(CartScreen.routeName, (route) => false);
                 // Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                color: txt=='CART'?const Color(0xffFFA44B): Colors.black),
            HeaderTextWidget(
              name: 'WALLET',
              image: AppImages.wallet2Icon,
              color: txt=='WALLET'?const Color(0xffFFA44B): Colors.black,
              ontap: () {
                txt='WALLET';
              },
            ),
            const SizedBox(
              width: 20,
            ),
            // SizedBox(
            //   width: 200,
            //   height: 40,
            //   child: CustomTextFormField(controller:_search,
            //   hint: 'Search',
            //   borderRadius: 0,
            //   borderColor: Colors.black,
            //   color: Color(0xffeeeeee),
            //   starticon: Icons.search,),),
            const SizedBox(
              width: 20,
            ),
            Container(
              width: 100,
              constraints: const BoxConstraints(
                maxWidth: 100,
                minWidth: 40,
              ),
              height: 40,
              decoration: BoxDecoration(
                  color: const Color(0xffFFA44B),
                  borderRadius: BorderRadius.circular(8)),
              child: const Center(
                  child: ForText(
                name: 'Signup',
                color: Colors.white,
              )),
            ),
          ],
        ),
      );
   }
}
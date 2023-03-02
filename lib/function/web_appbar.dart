import 'package:flutter/material.dart';
import'package:crypto_cent/widgets/custom_widgets/web/header_text_widget.dart';
import '../utilities/app_images.dart';
import '../widgets/custom_widgets/cutom_text.dart';

class WebAppBar{
  static AppBar get webAppBar => AppBar(
    leading: SizedBox(),
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
              color: Color(0xffFFA44B)),
          HeaderTextWidget(
              name: 'WISHLIST',
              image: AppImages.fvrtIcon,
              color: Colors.black),
         HeaderTextWidget(
              name: 'CART',
              image: AppImages.shoppingcartIcon,
            
              color: Colors.black),
          HeaderTextWidget(
              name: 'WALLET',
              image: AppImages.wallet2Icon,
              color: Colors.black),
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
            height: 40,
            decoration: BoxDecoration(
                 color: Color(0xffFFA44B),
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
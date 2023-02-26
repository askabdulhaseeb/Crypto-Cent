import 'package:flutter/material.dart';

import '../../utilities/app_images.dart';
import '../../widgets/custom_widgets/custom_widget.dart';
import '../../widgets/custom_widgets/footer_widget.dart';
import '../../widgets/custom_widgets/promo_widget.dart';
import '../../widgets/home/home_categories_list.dart';
import '../category_screens/categories_extend.dart';
import '../home_screen/web_home_screen.dart';

class WebScreen extends StatelessWidget {
    WebScreen({super.key});
  final TextEditingController _search=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: webscreenAppbar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          WebHomeScreen(),
            
                  const SizedBox(height: 20,),
            PromoWidget(),
            FooterWidget(),
          ],
        ),
      ),
    );
  }

  AppBar webscreenAppbar(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 200,
            height: 40,
            child: Image.asset(AppImages.logo),
          ),
          const Spacer(),
          headerTextWihImage(
              name: 'HOME',
              image: AppImages.homeUnselected,
              color: Theme.of(context).primaryColor),
          headerTextWihImage(
              name: 'WISHLIST',
              image: AppImages.fvrtIcon,
              color: Colors.black),
          headerTextWihImage(
              name: 'CART',
              image: AppImages.shoppingcartIcon,
            
              color: Colors.black),
          headerTextWihImage(
              name: 'WALLET',
              image: AppImages.wallet2Icon,
              color: Colors.black),
          const SizedBox(
            width: 20,
          ),
          SizedBox(
            width: 200,
            height: 40,
            child: CustomTextFormField(controller:_search,
            hint: 'Search',
            borderRadius: 0,
            borderColor: Colors.black,
            color: Color(0xffeeeeee),
            starticon: Icons.search,),),
          const SizedBox(
            width: 20,
          ),
          Container(
            width: 100,
            height: 40,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
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

  Widget headerTextWihImage(
      {required String name, required Color color, required String image}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: <Widget>[
          ForText(
            name: name,
            size: 15,
            color: color,
          ),
          const SizedBox(
            width: 5,
          ),
          SizedBox(
            height: 15,
            width: 15,
            child: Image.asset(image, color: color),
          )
        ],
      ),
    );
  }
}





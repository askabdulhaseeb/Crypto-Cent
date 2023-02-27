import 'package:flutter/material.dart';

import '../../function/web_appbar.dart';
import '../../utilities/app_images.dart';
import '../../widgets/custom_widgets/custom_widget.dart';
import '../../widgets/custom_widgets/footer_widget.dart';
import '../../widgets/custom_widgets/promo_widget.dart';
import '../../widgets/custom_widgets/web/header_text_widget.dart';
import '../../widgets/home/home_categories_list.dart';
import '../category_screens/categories_extend.dart';
import '../home_screen/web_home_screen.dart';

class WebMain extends StatelessWidget {
    WebMain({super.key});
  final TextEditingController _search=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WebAppBar.webAppBar,
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
}







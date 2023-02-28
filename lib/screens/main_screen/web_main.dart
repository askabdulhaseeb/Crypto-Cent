import 'package:flutter/material.dart';

import '../../function/web_appbar.dart';
import '../../widgets/custom_widgets/footer_widget.dart';
import '../../widgets/custom_widgets/promo_widget.dart';
import '../home_screen/home_screen.dart';

class WebMain extends StatelessWidget {
  WebMain({super.key});
  final TextEditingController _search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    return Scaffold(
      appBar: WebAppBar.webAppBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const HomeScreen(),
            const SizedBox(height: 20),
            PromoWidget(),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }
}

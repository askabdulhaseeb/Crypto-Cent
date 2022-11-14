import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/provider.dart';
import '../../utilities/app_images.dart';
import '../../widgets/custom_widgets/custom_widget.dart';

class OrderSuccefully extends StatelessWidget {
  const OrderSuccefully({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (() {
              Provider.of<AppProvider>(context, listen: false).onTabTapped(0);
              Navigator.pop(context);
            }),
            icon: const Icon(Icons.arrow_back_ios_sharp)),
        
        actions: const [Icon(Icons.more_vert)],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Theme.of(context).secondaryHeaderColor,
                    radius: 105,
                    child: SizedBox(
                        height: 120,
                        width: 120,
                        child: Image(
                          image: AssetImage(AppImages.orderSuccefully),
                          fit: BoxFit.fill,
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const ForText(
                name: 'Order placed successfully',
                bold: true,
                size: 20,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    'Thanks for your order. Your order has placed\nsuccessfilly.Please continue your order.',
                    maxLines: 2,
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.4),
              CustomElevatedButton(title: 'Continue', onTap: () {}),
              const SizedBox(height: 10),
              CustomElevatedButton(
                  title: 'Track Order',
                  onTap: () {},
                  border: Border.all(color: Theme.of(context).primaryColor),
                  textStyle: TextStyle(color: Theme.of(context).primaryColor),
                  bgColor: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

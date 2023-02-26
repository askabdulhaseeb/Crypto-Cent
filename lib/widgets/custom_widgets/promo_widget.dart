import 'package:flutter/material.dart';

import 'custom_widget.dart';

class PromoWidget extends StatelessWidget {
   PromoWidget({super.key});
   final TextEditingController _email=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xffFFCA4E), Color(0xffFFB04D)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          const ForText(
            name: 'JOIN SHOPPING COMMUNITY TO \nGET MONTHLY PROMO',
            bold: true,
            color: Colors.white,
            size: 25,
          ),
          const ForText(
            name: 'Type your email down below and be young wild generation',
            color: Colors.white,
            size: 15,
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 300,
            child: CustomTextFormField(controller: _email,borderRadius: 6,
            hint: 'Add your email here',
            sufixicon: Container(height: 40,width: 80,decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(child: ForText(name: 'SEND',color: Colors.white,size: 20,)),
            ),
            ))
        ],
      ),
    );
  }
}

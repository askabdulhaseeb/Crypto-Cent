// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../database/app_user/auth_method.dart';
import '../../../enum/location_type.dart';
import '../../../function/crypto_function.dart';
import '../../../function/time_date_function.dart';
import '../../../function/web_appbar.dart';
import '../../../models/location.dart';
import '../../../providers/add_product_p.dart';
import '../../../providers/cart_provider.dart';
import '../../../providers/location_provider.dart';
import '../../../providers/product_provider.dart';
import '../../../utilities/utilities.dart';
import '../../../widgets/custom_widgets/custom_widget.dart';
import '../../../widgets/custom_widgets/footer_widget.dart';
import '../../main_screen/main_screen.dart';
import '../../order/payment.dart';
import '../add_new_address.dart';

class WebLocationScreen extends StatefulWidget {
  const WebLocationScreen({required this.text, super.key});
  final String text;
  static const String routeName = '/locationScreen';

  @override
  State<WebLocationScreen> createState() => _WebLocationScreenState();
}

class _WebLocationScreenState extends State<WebLocationScreen> {
  int isSelectedIndex = 0;
  TextEditingController email=TextEditingController();
  TextEditingController name=TextEditingController();
  TextEditingController address=TextEditingController();
  TextEditingController town=TextEditingController();
  TextEditingController city=TextEditingController();
  TextEditingController zip=TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
     CartProvider cartProv=Provider.of<CartProvider>(context);
     LocationProvider locationPro = Provider.of<LocationProvider>(context);
   return Scaffold(
    appBar: WebAppBar().webAppBar(context),
    body: Column(
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Utilities.maxWidth),
          child: Padding(
            padding: const EdgeInsets.symmetric(  horizontal: 22,vertical: 12),
            child: Form(
              key: _formKey,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    const ForText(name: 'Adress',bold: true,),
                    CustomTextFormField(controller: email,hint: 'email',),
                    CustomTextFormField(controller: name,hint: 'name',),
                    CustomTextFormField(controller: address,hint: 'address',),
                    CustomTextFormField(controller: town,hint: 'town',),
                    Row(
                      children: [
                        SizedBox(
                          width: 200,
                          child: CustomTextFormField(controller: city,hint: 'city',)),
                        const SizedBox(width: 15,),
                    SizedBox(
                      width: 200,
                      child: CustomTextFormField(controller: city,hint: 'zip',)),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    SizedBox(
                      width: 200,
                      child: CustomElevatedButton(title: 'Proceed to checkout', onTap: ()async{
                        if (_formKey.currentState!.validate()) {
                            UserLocation location = UserLocation(
                              address: address.text,
                              city: city.text,
                              latitude:0,
                              longitude: 0,
                              locationName: address.text,
                              state: 'state.text',
                              userID: AuthMethods.uid,
                              locationID: AuthMethods.uid +
                                  TimeStamp.timestamp.toString(),
                              timestamp: TimeStamp.timestamp,
                              zipCode: zip.text,
                              phonenumber: '',
                              locationType:LocationType.delievery,
                            );
                            await locationPro.addLocation(location, context);
                            
                              }
                      })
                      )
                  ],),
                  Expanded(
                  child: Column(
                    children: [
                      const ForText(name: 'Order Summary',bold: true,size: 22,),
                       Row(
                      children: <Widget>[
                        const ForText(
                          name: 'Price',
                        ),
                        const Spacer(),
                        ForText(
                          name: 'USD: \$${cartProv.totalPrice()}',
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: const <Widget>[
                        ForText(name: 'Discount'),
                        Spacer(),
                        ForText(
                          name: '0',
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        const ForText(
                          name: 'Total Price',
                          bold: true,
                          size: 16,
                        ),
                        const Spacer(),
                        FutureBuilder<double>(
                            future: CryptoFunction()
                                .btcPrinceLive(dollor: cartProv.totalPrice()),
                            builder: (BuildContext context,
                                AsyncSnapshot<double> exchangeRate) {
                              return ForText(
                                name: exchangeRate.hasError
                                    ? '-- ERROR --'
                                    : exchangeRate.hasData
                                        ? 'Btc: ${exchangeRate.data!.toStringAsFixed(8)}'
                                        : 'fetching ...',
                                bold: true,
                                size: 16,
                              );
                            }),
                      ],
                    ),
                    
                    ],
                  ),
                ),
                ],
              ),
            ),
          ),
        ),
         const FooterWidget(),
      ],
    ),
   );
  }
}

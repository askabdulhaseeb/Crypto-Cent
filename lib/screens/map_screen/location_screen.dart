// ignore_for_file: use_build_context_synchronously, always_specify_types

import 'package:crypto_cent/widgets/custom_widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../models/location.dart';
import '../../providers/add_product_p.dart';
import '../../providers/app_provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/location_provider.dart';
import '../../providers/payment_provider.dart';
import '../../providers/product_provider.dart';
import '../../widgets/cart/order_success_contact_screen.dart';
import '../../widgets/custom_widgets/custom_widget.dart';
import '../../widgets/custom_widgets/show_loading.dart';
import '../main_screen/main_screen.dart';
import 'add_new_address.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({required this.text, super.key});
  final String text;
  static const String routeName = '/locationScreen';

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int isSelectedIndex = 0;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    LocationProvider locationPro = Provider.of<LocationProvider>(context);
    List<UserLocation> location = [];
    if (widget.text == 'product upload') {
      location = locationPro.currentUserProductLocation;
    } else {
      location = locationPro.currentUserLocation;
    }
    print('Product Location${locationPro.currentUserLocation.length}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Address'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.text == 'location'
                ? const SizedBox()
                : TextButton(
                    onPressed: () {
                      // Navigator.of(context).pushNamed(AddNewAddress.routeName);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => AddNewAddress(
                                isProduct: widget.text == 'product upload'
                                    ? true
                                    : false),
                          ));
                    },
                    child: const ForText(
                      name: '+ Add new Address',
                      bold: true,
                      color: Colors.green,
                    )),
            Expanded(
              child: ListView.builder(
                itemCount: location.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: GestureDetector(
                      onTap: () async {
                        await HapticFeedback.heavyImpact();
                        setState(() {
                          isSelectedIndex = index;
                        });
                      },
                      child: Container(
                        height: 90,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: isSelectedIndex == index
                                ? Theme.of(context).secondaryHeaderColor
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const SizedBox(
                                height: 40,
                                width: 40,
                                child: Icon(Icons.location_on),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: '${location[index].locationName} \n',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: '${location[index].address} \n',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w200)),
                                    TextSpan(
                                        text:
                                            '${location[index].city} ${location[index].state}',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w200)),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    color: isSelectedIndex == index
                                        ? Colors.yellow
                                        : Colors.transparent,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: isSelectedIndex == index
                                            ? Colors.white
                                            : const Color(0xff413547),
                                        width: 2.5)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            widget.text == 'product upload'
                ? Consumer2<AddProductProvider, ProductProvider>(builder:
                    (BuildContext context, AddProductProvider addProductPro,
                        ProductProvider productPro, _) {
                    return addProductPro.isupload
                        ? const CircularProgressIndicator()
                        : CustomElevatedButton(
                            title: 'Upload',
                            onTap: () async {
                              await HapticFeedback.heavyImpact();
                              await locationPro
                                  .selectedIndex(location[isSelectedIndex]);
                              bool temp = await addProductPro.upload(context);
                              if (temp) {
                                await productPro.load();
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute<MainScreen>(
                                      builder: (BuildContext context) =>
                                          const MainScreen(),
                                    ),
                                    (Route route) => false);
                              }
                            });
                  })
                : widget.text == 'order'
                    ? Consumer3<CartProvider, PaymentProvider, AppProvider>(
                        builder: (BuildContext context,
                            CartProvider cartPro,
                            PaymentProvider paymentPro,
                            AppProvider appPro,
                            Widget? snapshot) {
                        return isLoading
                            ? const ShowLoading()
                            : CustomElevatedButton(
                                title: 'Adress Done',
                                onTap: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  // CustomToast.successToast(
                                  //     message: 'Succefull order is done');
                                  await HapticFeedback.heavyImpact();
                                  await locationPro
                                      .selectedIndex(location[isSelectedIndex]);
                                  await paymentPro.productOrder(
                                      context: context, cartPro: cartPro);
                                  appPro.onTabTapped(0);
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const OrderSuccessContactScreen(),
                                  ));
                                  setState(() {
                                    isLoading = false;
                                  });
                                });
                      })
                    : const SizedBox(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/location_provider.dart';
import '../../widgets/custom_widgets/custom_widget.dart';
import '../order/payment.dart';
import 'add_new_address.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});
  static const String routeName = '/locationScreen';

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int isSelectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    LocationProvider locationPro = Provider.of<LocationProvider>(context);
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
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddNewAddress.routeName);
                },
                child: const ForText(
                  name: '+ Add new Address',
                  bold: true,
                  color: Colors.green,
                )),
            Expanded(
              child: ListView.builder(
                itemCount: locationPro.currentUserLocation.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: GestureDetector(
                      onTap: () {
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
                                  text:
                                      '${locationPro.currentUserLocation[index].locationName} \n',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: '${locationPro.currentUserLocation[index].address} \n',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w200)),
                                    TextSpan(
                                        text: '${locationPro.currentUserLocation[index].city} ${locationPro.currentUserLocation[index].state}',
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
            CustomElevatedButton(
                title: 'Adress Done',
                onTap: () async {
                  await locationPro.selectedIndex(
                      locationPro.currentUserLocation[isSelectedIndex]);
                  Navigator.of(context).pushNamed(PaymentScreen.routeName);
                }),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

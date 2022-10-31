import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../widgets/custom_widgets/custom_widget.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static double currentlat = 31.485722;
  static double currentlng = 74.32648689999996;
  CameraPosition cameraPosition =
      CameraPosition(zoom: 14, target: LatLng(currentlat, currentlng));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Contact Us'),
          leading: const Icon(Icons.arrow_back_ios_sharp),
          actions: const [Icon(Icons.more_vert)],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const ForText(name: 'Contact Us', bold: true),
                const SizedBox(height: 15),
                containers(
                    context, Icons.phone, '+92345 1234567', '+92345 1234567'),
                const SizedBox(height: 15),
                containers(context, Icons.email, 'bloodoapp@gmail.com', ''),
                const SizedBox(height: 15),
                containers(
                    context, Icons.location_on_sharp, 'Model Town,Lahore', ''),
                const SizedBox(height: 15),
                Container(
                  height: MediaQuery.of(context).size.width,
                  width: double.infinity,
                  color: Colors.black,
                  child: GoogleMap(
                    initialCameraPosition: cameraPosition,
                    markers: {
                      Marker(
                        onTap: () {
                          showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              context: context,
                              builder: ((context) {
                                return Container(
                                  height: 70,
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: const <Widget>[
                                      Icon(Icons.location_on),
                                      ForText(name: 'bloodo headquatar')
                                    ],
                                  ),
                                );
                              }));
                        },
                        markerId: const MarkerId('current location'),
                        position: LatLng(currentlat, currentlng),
                      ),
                    },
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ));
  }

  Widget containers(
      BuildContext context, IconData icon, String text, String? textt) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).secondaryHeaderColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Center(
                  child: Icon(
                icon,
                color: Colors.black,
              )),
            ),
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ForText(
                  name: text,
                  bold: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                textt == ''
                    ? const SizedBox()
                    : ForText(
                        name: textt!,
                        bold: true,
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

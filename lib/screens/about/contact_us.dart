import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../widgets/custom_widgets/custom_widget.dart';
import '../map_screen/map_screen.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  // ignore: always_specify_types
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
          leading: IconButton(
              onPressed: (() {
                Provider.of<AppProvider>(context, listen: false).onTabTapped(0);
                Navigator.pop(context);
              }),
              icon: const Icon(Icons.arrow_back_ios_sharp)),
          actions: const <Widget>[Icon(Icons.more_vert)],
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
                containers(context, Icons.email, 'boloodoapp@gmail.com', ''),
                const SizedBox(height: 15),
                containers(
                    context, Icons.location_on_sharp, 'Model Town,Lahore', ''),
                const SizedBox(height: 15),
                Container(
                  height: MediaQuery.of(context).size.width,
                  width: double.infinity,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black,
                  ),
                  child: GoogleMapWidget(latitude: 120,longitude: 130,),
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
              children: <Widget>[
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


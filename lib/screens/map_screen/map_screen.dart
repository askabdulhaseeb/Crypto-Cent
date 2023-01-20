import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../widgets/custom_widgets/cutom_text.dart';

class GoogleMapWidget extends StatefulWidget {
  GoogleMapWidget({
    this.longitude = 74.32648689999996,
    this.latitude = 31.485722,
  });

  double latitude;
  double longitude;

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  final Completer<GoogleMapController> _controller = Completer();
  late CameraPosition cameraPosition;
  late double currentlat;
  late double currentlng;
  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    currentlat = widget.latitude;
   currentlng = widget.longitude;
    cameraPosition =
        CameraPosition(zoom: 14, target: LatLng(currentlat, currentlng));
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: cameraPosition,
      // ignore: always_specify_types
      markers: {
        Marker(
          onTap: () {
            // showModalBottomSheet(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10.0),
            //     ),
            //     context: context,
            //     builder: ((BuildContext context) {
            //       return SizedBox(
            //         height: 70,
            //         width: double.infinity,
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceAround,
            //           children: const <Widget>[
            //             Icon(Icons.location_on),
            //             ForText(name: 'bloodo headquatar')
            //           ],
            //         ),
            //       );
            //     }));
          },
          markerId: const MarkerId('current location'),
          position: LatLng(currentlat, currentlng),
        ),
      },
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}

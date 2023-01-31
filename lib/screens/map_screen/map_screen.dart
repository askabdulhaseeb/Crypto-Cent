import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../widgets/custom_widgets/cutom_text.dart';

class GoogleMapWidget extends StatefulWidget {
  GoogleMapWidget({
    this.longitude = 74.32648689999996,
    this.latitude = 31.485722,
    required this.productName,
  });

  double latitude;
  double longitude;
  String productName;
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

// ignore: prefer_collection_literals
// Set<Circle> circles = Set.from([Circle(
//     circleId: CircleId('123'),
//     center: LatLng(widget.latitude, widget.longitude),
//     radius: 4000,
// )]);
  _init() {
    currentlat = widget.latitude;
    currentlng = widget.longitude;
    cameraPosition =
        CameraPosition(zoom: 12, target: LatLng(currentlat, currentlng));
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: cameraPosition,
      // ignore: always_specify_types
      markers: {
        Marker(
          onTap: () async {
            await HapticFeedback.heavyImpact();
          },
          markerId: const MarkerId('current location'),
          position: LatLng(currentlat, currentlng),
        ),
      },
      // ignore: always_specify_types
      // circles: {
      //   const Circle(
      //       circleId: CircleId('1'),
      //       fillColor: Colors.black,
      //       radius: 400,
      //       visible: true,
      //       strokeWidth: 3)
      // },
      circles: {
        Circle(
            circleId: const CircleId('123'),
            consumeTapEvents: true,
            strokeColor: Colors.orange,
            fillColor: Colors.black.withOpacity(0.3),
            strokeWidth: 2,
            // center: _createCenter(),
            onTap: () {
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  context: context,
                  builder: ((BuildContext context) {
                    return SizedBox(
                      height: 70,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(Icons.location_on),
                          const SizedBox(
                            width: 20,
                          ),
                          ForText(name: widget.productName)
                        ],
                      ),
                    );
                  }));
            },
            radius: 5000,
            center: LatLng(currentlat, currentlng))
      },
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import '../database/location.dart';
import '../models/location.dart';
import '../widgets/custom_widgets/custom_toast.dart';

class LocationProvider with ChangeNotifier {
  UserLocation? _userLocation;
  bool isLoading = false;
  UserLocation get userLocation => _userLocation ?? _null;
  UserLocation get _null => UserLocation(
      userLocationID: '',
      userID: '',
      locationName: '',
      latitude: 0,
      longitude: 0,
      address: '',
      city: '',
      state: '',
      zipCode: '');
  addLocation(UserLocation location) async {
    isLoading = true;
    notifyListeners();
    _userLocation = location;
    // if (_userLocation!.latitude == 0) {
    //   final String fulladdress =  '${location.address},${location.city},${location.state}';
    //   print(fulladdress);
    //   final List<Location> locations = await locationFromAddress('Next space Block R1 Johar Town,Lahore,Pakistan');
    //   _userLocation!.latitude = locations.first.latitude;
    //   _userLocation!.longitude = locations.first.longitude;
    //   List<Placemark> addresses = await placemarkFromCoordinates(
    //       locations.first.latitude, locations.first.longitude);
    // }

    bool temp = await LocationApi().add(_userLocation!);
    if (temp == true) {
      CustomToast.successToast(message: 'Location Update');
      isLoading = false;
    notifyListeners();
    }
  }
}

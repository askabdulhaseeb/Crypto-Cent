import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import '../database/location_api.dart';
import '../models/location.dart';
import '../widgets/custom_widgets/custom_toast.dart';

class LocationProvider with ChangeNotifier {
  LocationProvider() {
    load();
  }
   Future<void> load() async {
    _allUserLocation = await LocationApi().getdata();
    notifyListeners();
  }
  UserLocation? _userLocation;
  UserLocation? _selectLocation;
  List<UserLocation> _allUserLocation = [];
  List<UserLocation> get allUserLocation => _allUserLocation;
  bool isLoading = false;
  UserLocation get userLocation => _userLocation ?? _null;
  UserLocation get selectLocation => _selectLocation ?? _null;
  addLocation(UserLocation location, BuildContext context) async {
    isLoading = true;
    notifyListeners();
    _userLocation = location;
    _allUserLocation.add(location);
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
      Navigator.of(context).pop();
    }
  }

  selectedIndex(UserLocation value) {
    _selectLocation = value;
    notifyListeners();
  }

  UserLocation get _null => UserLocation(
      locationID: '',
      userID: '',
      locationName: '',
      latitude: 0,
      longitude: 0,
      address: '',
      city: '',
      state: '',
      timestamp: 0,
      zipCode: '');
}

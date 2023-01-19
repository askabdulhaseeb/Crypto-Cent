import 'package:flutter/material.dart';
import '../database/app_user/auth_method.dart';
import '../database/location_api.dart';
import '../models/location.dart';
import '../widgets/custom_widgets/custom_toast.dart';

class LocationProvider with ChangeNotifier {
  LocationProvider() {
    load();
  }
  Future<void> load() async {
    _allUserLocation = await LocationApi().getdata();
    userLocationwithUID();
    debugPrint('all user Length LOcation:  ${_allUserLocation.length}');
    notifyListeners();
  }

  userLocationwithUID() {
    for (int i = 0; i < _allUserLocation.length; i++) {
      if (_allUserLocation[i].userID == AuthMethods.uid) {
        _currentUserLocation.add(_allUserLocation[i]);
      }
    }
  }

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
      load();
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
  UserLocation? _userLocation;
  UserLocation? _selectLocation;
  List<UserLocation> _allUserLocation = <UserLocation>[];
  List<UserLocation> get allUserLocation => _allUserLocation;
  final List<UserLocation> _currentUserLocation = <UserLocation>[];
  List<UserLocation> get currentUserLocation => _currentUserLocation;
  bool isLoading = false;
  UserLocation get userLocation => _userLocation ?? _null;
  UserLocation get selectLocation => _selectLocation ?? _null;
}

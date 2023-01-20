import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../../database/app_user/auth_method.dart';
import '../../enum/location_type.dart';
import '../../function/time_date_function.dart';
import '../../models/location.dart';
import '../../providers/location_provider.dart';
import '../../widgets/custom_widgets/custom_toast.dart';
import '../../widgets/custom_widgets/custom_widget.dart';

class AddNewAddress extends StatefulWidget {
  const AddNewAddress({required this.isProduct,super.key});
  static const String routeName = '/addNewAddress';
  final bool isProduct;
  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  TextEditingController locationName = TextEditingController();

  final TextEditingController address = TextEditingController();

  final TextEditingController city = TextEditingController();

  final TextEditingController state = TextEditingController();

  final TextEditingController zipCode = TextEditingController();

  final TextEditingController phoneNumber = TextEditingController();
  double latitude = 0;
  double longitude = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  _getLocation() async {
// GeolocationStatus geolocationStatus = await
// Geolocator().checkGeolocationPermissionStatus();
    bool isServiceEnabled;
    LocationPermission locationPermission;
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      return CustomToast.errorToast(message: 'Location not Found');
    }
    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error('Location permission denied forever');
    } else if (locationPermission == LocationPermission.denied) {
      //request new permission
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error('Location permission is denied');
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    debugPrint('location: ${position.latitude}');
    latitude = position.latitude;
    longitude = position.longitude;
    List<Placemark> addresses =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    //await locationFromAddress('');
    print(addresses.last.street.toString());
    setState(() {
      address.text = addresses.last.street.toString();
      city.text = addresses.first.locality.toString();
      state.text = addresses.first.country.toString();
      zipCode.text = addresses.first.postalCode.toString();
    });
  }

  getLatlong() async {
    final List<Location> locations =
        await locationFromAddress('Block R1 Johar Town,Lahore,pakistan');
    List<Placemark> addresses = await placemarkFromCoordinates(
        locations.first.latitude, locations.first.longitude);
    print(addresses.first);
  }

  @override
  Widget build(BuildContext context) {
    LocationProvider locationPro = Provider.of<LocationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New address'),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextButton(
                    onPressed: () {
                      _getLocation();
                    },
                    child: const ForText(
                      name: '+Use my Current Location ',
                      color: Colors.green,
                    )),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  controller: locationName,
                  hint: 'Location Name',
                  color: Colors.white,
                  validator: (String? value) =>
                      CustomValidator.lessThen2(value),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  controller: phoneNumber,
                  hint: 'phone Number',
                  color: Colors.white,
                  validator: (String? value) =>
                      CustomValidator.lessThen2(value),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  controller: address,
                  hint: 'Address',
                  color: Colors.white,
                  validator: (String? value) =>
                      CustomValidator.lessThen2(value),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  controller: city,
                  hint: 'City',
                  color: Colors.white,
                  validator: (String? value) =>
                      CustomValidator.lessThen2(value),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  controller: state,
                  hint: 'State',
                  color: Colors.white,
                  validator: (String? value) =>
                      CustomValidator.lessThen2(value),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  controller: zipCode,
                  hint: 'Zip Code',
                  color: Colors.white,
                  validator: (String? value) =>
                      CustomValidator.lessThen2(value),
                ),
                const SizedBox(
                  height: 20,
                ),
                locationPro.isLoading
                    ? const CircularProgressIndicator()
                    : CustomElevatedButton(
                        title: 'Add Address',
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            UserLocation location = UserLocation(
                              address: address.text,
                              city: city.text,
                              latitude: latitude,
                              longitude: longitude,
                              locationName: locationName.text,
                              state: state.text,
                              userID: AuthMethods.uid,
                              locationID: AuthMethods.uid +
                                  TimeStamp.timestamp.toString(),
                              timestamp: TimeStamp.timestamp,
                              zipCode: zipCode.text,
                              phonenumber: phoneNumber.text,
                              locationType:widget.isProduct?LocationType.product :LocationType.delievery,
                            );
                            await locationPro.addLocation(location, context);
                            if (locationPro.isLoading) {
                              address.clear();
                              phoneNumber.clear();
                              city.clear();
                              locationName.clear();
                              state.clear();
                            }
                          }
                          //getLatlong();
                        })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

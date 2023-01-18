import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../widgets/custom_widgets/custom_textformfield.dart';
import '../../widgets/custom_widgets/custom_toast.dart';
import '../../widgets/custom_widgets/custom_validator.dart';
import '../../widgets/custom_widgets/custom_widget.dart';

class AddNewAddress extends StatefulWidget {
  AddNewAddress({super.key});

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
      return Future.error("Location permission denied forever");
    } else if (locationPermission == LocationPermission.denied) {
      //request new permission
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location permission is denied");
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    debugPrint('location: ${position.latitude}');
    
    List<Placemark> addresses =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    debugPrint('street: ${addresses.last}');
    debugPrint('Address: ${addresses.first.street}');
    debugPrint('Address: ${addresses.length}');
    setState(() {
      address.text = addresses.last.street.toString();
      city.text = addresses.first.locality.toString();
      state.text = addresses.first.country.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    child: ForText(
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
                CustomElevatedButton(title: 'Add Address', onTap: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

import '../enum/location_type.dart';

class UserLocation {
  final String locationID;
  final String userID;
  final String locationName;
  double latitude;
  double longitude;
  final String address;
  final String city;
  final LocationType locationType;
  final String state;
  final String zipCode;
  final int timestamp;
  String? phonenumber;
  UserLocation({
    required this.locationID,
    required this.userID,
    required this.locationName,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.locationType,
    this.phonenumber,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'locationID': locationID,
      'userID': userID,
      'locationName': locationName,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'phonenumber': phonenumber,
      'timestamp': timestamp,
      'location_type':locationType.json,
    };
  }

  factory UserLocation.fromMap(DocumentSnapshot<Map<String, dynamic>> doc) {
    return UserLocation(
      locationID: doc.data()?['locationID'] ?? '',
      userID: doc.data()?['userID'] ?? '',
      locationName: doc.data()?['locationName'] ?? '',

      latitude:double.parse(doc.data()?['latitude'].toString()??'0' ),
      longitude: double.parse(doc.data()?['longitude'].toString()??'0' ),

      address: doc.data()?['address'] ?? '',
      city: doc.data()?['city'] ?? '',
      state: doc.data()?['state'] ?? '',
      zipCode: doc.data()?['zipCode'] ?? '',
      phonenumber: doc.data()?['phonenumber'] ?? '',
      timestamp: doc.data()?['timestamp'] ?? 0,
      locationType: LocationTypeConverter().toEnum(doc.data()?['location_type'] ?? LocationType.delievery.json),
    );
  }
}

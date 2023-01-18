// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../function/time_date_function.dart';

class UserLocation {
  final String locationID;
  final String userID;
  final String locationName;
  double latitude;
  double longitude;
  final String address;
  final String city;
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
    };
  }

  factory UserLocation.fromMap(DocumentSnapshot<Map<String, dynamic>> doc) {
    return UserLocation(
      locationID: doc.data()?['locationID'] ?? '',
      userID: doc.data()?['userID'] ?? '',
      locationName: doc.data()?['locationName'] ?? '',
      latitude: doc.data()?['latitude'] ?? 0.0,
      longitude: doc.data()?['longitude'] ?? 0.0,
      address: doc.data()?['address'] ?? '',
      city: doc.data()?['city'] ?? '',
      state: doc.data()?['state'] ?? '',
      zipCode: doc.data()?['zipCode'] ?? '',
      phonenumber: doc.data()?['phonenumber'] ?? '',
      timestamp: doc.data()?['timestamp'] ?? 0,
    );
  }
}

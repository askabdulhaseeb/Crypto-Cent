import 'package:cloud_firestore/cloud_firestore.dart';


import '../models/location.dart';
import '../widgets/custom_widgets/custom_toast.dart';

class LocationApi{
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static const String _collection = 'location';
   Future<bool> add(UserLocation value) async {
    try {
      await _instance
          .collection(_collection)
          .doc(value.userID)
          .set(value.toMap());
      // CustomToast.successToast(message: 'Successfully Added');
      return true;
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
      return false;
    }
  }
}
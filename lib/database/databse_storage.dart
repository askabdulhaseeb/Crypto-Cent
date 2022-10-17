import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../function/time_date_function.dart';

class Storagemethod {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int uuid = TimeStamp.timestamp;
  Future<String> uploadtostorage(String collection, Uint8List file) async {
    Reference ref = _storage
        .ref()
        .child(collection)
        .child(_auth.currentUser!.uid)
        .child(uuid.toString());
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downloadurl = await snap.ref.getDownloadURL();
    return downloadurl;
  }
}

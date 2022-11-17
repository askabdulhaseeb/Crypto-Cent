import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

import '../function/time_date_function.dart';

class Storagemethod {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  int uuid = TimeStamp.timestamp;
  Future<String> uploadtostorage(
    String collection,
    String createrid, {
    File? file,
    Uint8List? uint8list,
  }) async {
    Reference ref = _storage
        .ref()
        .child(collection)
        .child(createrid)
        .child(uuid.toString());

    UploadTask uploadTask =
        file != null ? ref.putFile(file) : ref.putData(uint8list!);
    TaskSnapshot snap = await uploadTask;
    String downloadurl = await snap.ref.getDownloadURL();
    return downloadurl;
  }
}

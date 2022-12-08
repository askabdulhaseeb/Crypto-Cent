import 'dart:io';

import 'package:image_picker/image_picker.dart';

class AttachmentPicker {
  Future<List<File?>> multiImage() async {
    final List<File?> temp = <File?>[];
    final ImagePicker imagePicker = ImagePicker();
    List<XFile> result = await imagePicker.pickMultiImage();
    if (result.isEmpty) return <File?>[];
    for (int i = 0; i < result.length && i < 10; i++) {
      temp.add(File(result[i].path));
    }
    for (int i = result.length; i < 10; i++) {
      temp.add(null);
    }
    return temp;
  }

  Future<File?> gallery() async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? result = await imagePicker.pickImage(source: ImageSource.gallery);
    if (result == null) return null;
    return File(result.path);
  }

  Future<List<File?>> camera() async {
    final List<File?> temp = <File?>[];
    final ImagePicker imagePicker = ImagePicker();
    XFile? result = await imagePicker.pickImage(source: ImageSource.camera);
    if (result == null) return <File?>[];
    temp.add(File(result.path));
    for (int i = 1; i < 10; i++) {
      temp.add(null);
    }
    return temp;
  }

  Future<List<File>> multiPicNotNULL() async {
    final List<File> temp = <File>[];
    final ImagePicker imagePicker = ImagePicker();
    List<XFile> result = await imagePicker.pickMultiImage();
    if (result.isEmpty) return <File>[];
    for (int i = 0; i < result.length && i < 10; i++) {
      temp.add(File(result[i].path));
    }
    return temp;
  }

  Future<List<File>> cameraNotNULL() async {
    final List<File> temp = <File>[];
    final ImagePicker imagePicker = ImagePicker();
    XFile? result = await imagePicker.pickImage(source: ImageSource.camera);
    if (result == null) return <File>[];
    temp.add(File(result.path));
    return temp;
  }
}

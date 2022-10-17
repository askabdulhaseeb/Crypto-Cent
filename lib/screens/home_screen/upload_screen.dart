import 'package:flutter/material.dart';

class UploadScreen extends StatelessWidget {
  static const String routeName = '/UploadScreen';
  const UploadScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UploadScreen'),
      ),
    );
  }
}

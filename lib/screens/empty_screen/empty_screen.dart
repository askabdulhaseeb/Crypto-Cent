import 'package:flutter/material.dart';

import '../../widgets/custom_widgets/custom_widget.dart';
import '../main_screen/main_navigationbar.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});
  static const String routeName = '/emaptyScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: ForText(
          name: 'Coming Soon...',
          bold: true,
          size: 26,
        ),
      ),
    );
  }
}

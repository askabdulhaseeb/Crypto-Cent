import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/app_provider.dart';
import '../../widgets/custom_widgets/custom_widget.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('About Us'),
          leading: IconButton(
              onPressed: (() {
                Provider.of<AppProvider>(context, listen: false).onTabTapped(0);
                Navigator.pop(context);
              }),
              icon: const Icon(Icons.arrow_back_ios_sharp)),
          // ignore: always_specify_types
          actions: const [Icon(Icons.more_vert)],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              ForText(name: 'About Us', bold: true),
              SizedBox(height: 15),
              ForText(
                  name:
                      '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets.'''),
            ],
          ),
        ));
  }
}

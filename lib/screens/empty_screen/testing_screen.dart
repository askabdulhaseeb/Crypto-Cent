import 'package:flutter/material.dart';

import '../../widgets/custom_widgets/cutom_text.dart';

class TestingScreen extends StatefulWidget {
  const TestingScreen({super.key});

  @override
  State<TestingScreen> createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  String name = 'Running';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                newMethod(context, 'All', () {
                  setState(() {
                    name = 'All';
                  });
                  print(name);
                }, name),
                newMethod(context, 'Running', () {
                  setState(() {
                    name = 'Running';
                  });
                  print(name);
                }, name),
                newMethod(context, 'Previous', () {
                  setState(() {
                    name = 'Previous';
                  });
                  print(name);
                }, name),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget newMethod(
      BuildContext context, String title, VoidCallback onTap, String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          decoration: BoxDecoration(
            color: title == name
                ? Theme.of(context).primaryColor
                : Theme.of(context).secondaryHeaderColor,
            borderRadius: BorderRadius.circular(46),
          ),
          child: Center(
            child: ForText(
              name: title,
              color: Colors.white,
              size: 20,
              bold: true,
            ),
          ),
        ),
      ),
    );
  }
}

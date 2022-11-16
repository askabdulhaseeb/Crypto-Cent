import 'package:flutter/material.dart';

import 'custom_bar_line.dart';

class CustomBarChart extends StatelessWidget {
  const CustomBarChart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 350,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              Column(
                children: const <Widget>[
                  Text('100%'),
                  SizedBox(
                    height: 20,
                  ),
                  Text('800%'),
                  SizedBox(
                    height: 20,
                  ),
                  Text('600%'),
                  SizedBox(
                    height: 20,
                  ),
                  Text('40%'),
                  SizedBox(
                    height: 20,
                  ),
                  Text('20%'),
                ],
              ),
              const CustomBarLine(),
              const CustomBarLine(),
            ],
          ),
        ));
  }
}

import 'package:flutter/material.dart';

import '../custom_widget.dart';

class CustomBarLine extends StatelessWidget {
  const CustomBarLine({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 16,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: 16,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const ForText(
          name: 'Confirmed',
          bold: true,
        )
      ],
    );
  }
}

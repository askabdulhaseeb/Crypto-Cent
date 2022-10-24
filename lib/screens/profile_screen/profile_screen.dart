import 'package:flutter/material.dart';

import '../../widgets/custom_widgets/custom_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
      body: Column(
        children: <Widget>[
          uperscreen(context),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[middelItems(context), middelItems(context)],
          ),
        ],
      ),
    );
  }

  Container middelItems(BuildContext context) {
    return Container(
      height: 80,
      width: 173,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget uperscreen(BuildContext context) {
    return Container(
      height: 220,
      width: double.infinity,
      color: Theme.of(context).primaryColor,
      child: Column(
        children: const <Widget>[
          CircleAvatar(
            radius: 64,
            backgroundColor: Colors.white,
          ),
          SizedBox(
            height: 10,
          ),
          ForText(
            name: 'Usman Afzal',
            size: 20,
            bold: true,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}

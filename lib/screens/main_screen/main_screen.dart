import 'package:flutter/material.dart';
class Dashboard extends StatelessWidget {
static const String routeName = '/Dashboard';
const Dashboard({super.key});
@override
 Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Dashboard'),
),
);
}
}
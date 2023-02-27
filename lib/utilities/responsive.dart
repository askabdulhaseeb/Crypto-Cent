import 'package:flutter/material.dart';

class ResponsiveApp extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ResponsiveApp({
    Key? key,
    required this.desktop,
    required this.mobile,
    required this.tablet,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 800.0;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 800.0 &&
      MediaQuery.of(context).size.width < 1000.0;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1000.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth >= 1000.0) {
          return desktop;
        } else if (constraints.maxWidth >= 800 &&
            constraints.maxWidth < 1000.0) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}

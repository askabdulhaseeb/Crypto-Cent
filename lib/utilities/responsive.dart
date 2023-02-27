import 'package:flutter/material.dart';

import 'utilities.dart';

class ResponsiveApp extends StatelessWidget {
  const ResponsiveApp({
    required this.desktop,
    required this.mobile,
    required this.tablet,
    Key? key,
  }) : super(key: key);
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < Utilities.mobileMaxWidth;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= Utilities.mobileMaxWidth &&
      MediaQuery.of(context).size.width < Utilities.tabMaxWidth;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= Utilities.tabMaxWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (isDesktop(context)) {
          return desktop;
        } else if (isTablet(context)) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}

import 'package:flutter/material.dart';

class CustomScreenManager extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;

  const CustomScreenManager({
    super.key,
    required this.mobile,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 1200) {
      return mobile;
    } else {
      return desktop;
    }
  }
}

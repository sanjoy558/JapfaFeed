import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyAppScrollBehavior extends ScrollBehavior {
  final Color glowColor;

  MyAppScrollBehavior({required this.glowColor}); // Accept color as a parameter

  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return GlowingOverscrollIndicator(
      axisDirection: axisDirection, // Dynamically sets axis direction
      color: glowColor, // Use the custom color
      child: child,
    );
  }
}
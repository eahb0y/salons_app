import 'package:flutter/material.dart';

class CustomPointerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..moveTo(size.width/2, size.height)   // move path point to (w/2,0)
      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

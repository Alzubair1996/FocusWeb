import 'package:flutter/material.dart';

class CustomClipperExample extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {

    final path = Path()
      ..lineTo(size.width, 0) // الجزء العلوي
      ..lineTo(size.width, size.height) // الجزء السفلي
      ..lineTo(0, size.height) // الجزء السفلي الآخر
      ..lineTo(0, size.height - 20.0) // جعل زاوية محننة
      ..quadraticBezierTo(0, size.height, 20.0, size.height); // الزاوية المنحنية
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
import 'dart:math';

import 'package:flutter/material.dart';
class CurvedTrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xff284448)
      ..style = PaintingStyle.fill;

    Path path = Path();

    // Define points for the inverted triangle
    Offset point1 = Offset(size.width / 2, size.height);
    Offset point2 = Offset(size.width, 0);
    Offset point3 = Offset(0, 0);

    // Move to the first point
    path.moveTo(point1.dx, point1.dy);

    // Draw curves between points
    path.quadraticBezierTo(size.width / 2, 2 * size.height / 3, point2.dx, point2.dy);
    path.quadraticBezierTo(size.width / 2, 0, point3.dx, point3.dy);
    path.quadraticBezierTo(size.width / 2, 2 * size.height / 3, point1.dx, point1.dy);

    // Close the path
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
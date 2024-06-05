import 'package:flutter/material.dart';

class BoundingBoxPainter extends CustomPainter {
  final double x;
  final double y;
  final double width;
  final double height;

  BoundingBoxPainter({required this.x, required this.y, required this.width, required this.height});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    Rect rect = Rect.fromLTWH(x, y, width, height);

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class BoundingBoxImage extends StatelessWidget {
  final ImageProvider imageProvider;
  final double x;
  final double y;
  final double width;
  final double height;

  BoundingBoxImage({required this.imageProvider, required this.x, required this.y, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(image: imageProvider),
        CustomPaint(
          size: Size(double.infinity, double.infinity),
          painter: BoundingBoxPainter(x: x, y: y, width: width, height: height),
        ),
      ],
    );
  }
}
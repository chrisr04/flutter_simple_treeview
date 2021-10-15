import 'package:flutter/material.dart';

class RectLine extends CustomPainter {
  bool isNephew;
  Color? pathColor;
  double? strokeWidth;

  RectLine({
    required this.isNephew,
    this.pathColor,
    this.strokeWidth,
  }) {
    _paint = Paint()
      ..color = pathColor ?? Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth ?? 3.0
      ..strokeCap = StrokeCap.round;
  }

  late Paint _paint;

  @override
  void paint(Canvas canvas, Size size) {
    if (isNephew) {
      canvas.drawLine(
        Offset(0.0, 0.0),
        Offset(0.0, size.height),
        _paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

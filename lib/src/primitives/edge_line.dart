import 'package:flutter/material.dart';
import 'tree_theme.dart';

class EdgeLine extends CustomPainter {
  bool isLast;
  bool isFirst;
  bool hasBrothers;
  bool hasChildren;
  bool isExpanded;
  LineType lineType;
  double indent;
  double avatarRadius;
  Color? pathColor;
  double? strokeWidth;

  EdgeLine({
    required this.isLast,
    required this.isFirst,
    required this.hasBrothers,
    required this.hasChildren,
    required this.isExpanded,
    required this.indent,
    required this.avatarRadius,
    required this.lineType,
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
    if (!isFirst) {
      switch (lineType) {
        case LineType.curved:
          final Path path = Path();
          path.moveTo(0.0, 0.0);
          path.cubicTo(
            0.0,
            0.0,
            0.0,
            avatarRadius + 1,
            indent / 2,
            avatarRadius + 1,
          );
          canvas.drawPath(path, _paint);
          break;
        case LineType.squared:
          canvas.drawLine(
            Offset(0.0, 0.0),
            Offset(0.0, avatarRadius + 1),
            _paint,
          );
          canvas.drawLine(
            Offset(0.0, avatarRadius + 1),
            Offset(avatarRadius + 1, avatarRadius + 1),
            _paint,
          );
          break;
        default:
      }
    }

    if (hasBrothers && !isLast) {
      canvas.drawLine(
        Offset(0.0, 0.0),
        Offset(0.0, size.height),
        _paint,
      );
    }

    if (hasChildren && isExpanded) {
      canvas.drawLine(
        Offset(indent, 2 * avatarRadius + 1),
        Offset(indent, size.height),
        _paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

import 'package:flutter/material.dart';

class TreeTheme {
  final double? lineWidth;
  final Color? lineColor;
  final LineType? lineType;
  final Color? nodeColor;

  const TreeTheme({
    this.lineWidth,
    this.lineColor,
    this.nodeColor,
    this.lineType,
  });
}

enum LineType {
  curved,
  squared,
}

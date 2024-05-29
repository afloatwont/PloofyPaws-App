import 'package:flutter/material.dart';

class FilledDotPainter extends CustomPainter {
  final Color color;
  final double dotSize;
  final double gap;

  FilledDotPainter({this.color = Colors.black, this.dotSize = 5.0, this.gap = 2.0});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    double startX = 0;
    double startY = 0;

    while (startY < size.height) {
      while (startX < size.width) {
        canvas.drawCircle(Offset(startX + dotSize / 2, startY + dotSize / 2), dotSize / 2, paint);
        startX += dotSize + gap;
      }
      startX = 0;
      startY += dotSize + gap;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

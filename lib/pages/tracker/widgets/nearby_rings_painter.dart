import 'package:flutter/material.dart';
import 'package:restoe/config/theme/theme.dart';

class RingPainter extends CustomPainter {
  final Animation<double> animation;

  RingPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final double maxRadius = size.width / 2;
    final double minRadius = size.width / 8;

    for (int i = 0; i < 3; i++) {
      double progress = (animation.value + i / 3) % 1;
      double radius = minRadius + (maxRadius - minRadius) * progress;
      paint.color = primary.withOpacity(1 - progress);
      canvas.drawCircle(size.center(Offset.zero), radius, paint);
    }
  }

  @override
  bool shouldRepaint(RingPainter oldDelegate) {
    return oldDelegate.animation != animation;
  }
}

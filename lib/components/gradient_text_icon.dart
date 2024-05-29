import 'package:flutter/material.dart';

class GradientIcon extends StatelessWidget {
  final IconData iconData;
  final LinearGradient gradient;
  final double size;

  const GradientIcon({
    super.key,
    required this.iconData,
    required this.gradient,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return gradient.createShader(bounds);
      },
      child: Icon(
        iconData,
        color: Colors.white, // This color won't be used because of the ShaderMask
        size: size,
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final LinearGradient gradient;

  const GradientText({
    super.key,
    required this.text,
    this.style,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return gradient.createShader(bounds);
      },
      child: Text(
        text,
        style: style ??
            const TextStyle(
              color: Colors.white, // This color won't be used because of the ShaderMask
              fontSize: 16, // Adjust as needed
              fontWeight: FontWeight.bold, // Adjust as needed
            ),
      ),
    );
  }
}

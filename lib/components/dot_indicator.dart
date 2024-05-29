import 'package:flutter/material.dart';

class AnimatedDotIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;
  final Color dotColor;
  final Color selectedDotColor;
  final double dotSize;
  final double spacing;
  final Duration duration;

  const AnimatedDotIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
    this.dotColor = Colors.grey,
    this.selectedDotColor = Colors.black,
    this.dotSize = 4.0,
    this.spacing = 4.0,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (index) => AnimatedContainer(
          duration: duration,
          width: index == currentIndex ? 40.0 : 10.0,
          height: dotSize,
          margin: EdgeInsets.symmetric(horizontal: spacing / 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: index == currentIndex ? selectedDotColor : dotColor,
          ),
        ),
      ),
    );
  }
}

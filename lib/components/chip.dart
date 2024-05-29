import 'package:flutter/material.dart';
import 'package:restoe/config/theme/theme.dart';

class Chip extends StatelessWidget {
  final String label;
  final String color;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const Chip({
    super.key,
    required this.label,
    this.color = 'primary',
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    Color color = colors(context).highlight.s900;
    Color bgColor = colors(context).highlight.s900;

    switch (this.color) {
      case 'primary':
        color = colors(context).highlight.s900;
        bgColor = colors(context).highlight.s50;
        break;
      case 'success':
        color = colors(context).success.s900;
        bgColor = colors(context).success.s50;
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? bgColor,
        borderRadius: BorderRadius.circular(99),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      child: Row(
        children: [
          if (icon != null)
            Icon(
              icon,
              color: foregroundColor ?? color,
            ),
          if (icon != null)
            const SizedBox(
              width: 4,
            ),
          Text(
            label,
            style: typography(context).smallBody.copyWith(
                  color: foregroundColor ?? color,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}

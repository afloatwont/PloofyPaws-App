import 'package:flutter/material.dart';
import 'package:ploofypaws/config/theme/theme.dart';

class InputLabel extends StatelessWidget {
  final String label;
  final bool required;
  final bool noMargin;
  final double? size;

  const InputLabel({super.key, this.noMargin = false, required this.label, this.required = false, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: noMargin ? null : const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: label,
              style: typography(context).smallBody.copyWith(
                    fontWeight: required ? FontWeight.normal : FontWeight.bold,
                    color: required ? Colors.black : colors(context).onSurface.s600,
                    letterSpacing: 0.1,
                    fontSize: size ?? 14,
                  ),
            ),
            if (required)
              TextSpan(
                text: '*',
                style: typography(context).body.copyWith(color: colors(context).critical.s500),
              ),
          ],
        ),
      ),
    );
  }
}

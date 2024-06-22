import 'package:flutter/material.dart';
import 'package:ploofypaws/config/theme/theme.dart';

class Tag extends StatelessWidget {
  final String label;
  final String color;
  final String size;

  const Tag({super.key, required this.label, this.color = 'primary', this.size = 'sm'});

  EdgeInsets _getSize() {
    switch (size) {
      case 'sm':
        return const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 2,
        );
      case 'md':
        return const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 4,
        );
    }

    throw ErrorDescription('Invalid size supplied to Tag');
  }

  @override
  Widget build(BuildContext context) {
    Color color = colors(context).highlight.s600;
    Color bgColor = colors(context).highlight.s50;

    switch (this.color) {
      case 'primary':
        color = colors(context).highlight.s600;
        bgColor = colors(context).highlight.s50;
        break;
      case 'success':
        color = colors(context).success.s600;
        bgColor = colors(context).success.s50;
        break;
      case 'critical':
        color = colors(context).critical.s600;
        bgColor = colors(context).critical.s50;
        break;
      case 'warning':
        color = colors(context).warning.s600;
        bgColor = colors(context).warning.s50;
        break;
      case 'onSurface':
        color = colors(context).onSurface.s600;
        bgColor = colors(context).onSurface.s50;
        break;
      case 'decorative.one':
        color = colors(context).decorative.one.s100;
        bgColor = colors(context).decorative.one.s50;
        break;
      case 'decorative.two':
        color = colors(context).decorative.two.s100;
        bgColor = colors(context).decorative.two.s50;
        break;
      case 'decorative.three':
        color = colors(context).decorative.three.s100;
        bgColor = colors(context).decorative.three.s50;
        break;
      case 'decorative.four':
        color = colors(context).decorative.four.s100;
        bgColor = colors(context).decorative.four.s50;
        break;
      case 'common.black':
        color = colors(context).common.white!.s500;
        bgColor = colors(context).common.black!.s500;
        break;
      case 'common.white':
        color = colors(context).common.black!.s500;
        bgColor = colors(context).common.white!.s500;
        break;
    }

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(4),
        ),
        padding: _getSize(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Text(
            label,
            style: typography(context).smallBody.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
          ),
        ),
      ),
    );
  }
}

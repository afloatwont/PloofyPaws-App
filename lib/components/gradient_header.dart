import 'package:flutter/material.dart';
import 'package:restoe/config/theme/theme.dart';

class GradientHeader extends StatelessWidget {
  final Widget? title;
  final Widget? leading;
  final Widget? trailing;

  const GradientHeader({super.key, this.title, this.leading, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.bottomRight,
              colors: [
                colors(context).warning.s500,
                colors(context).primary.s700,
              ],
            ),
          ),
        ),
        Container(
          height: 45,
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (leading != null)
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: leading!,
                ),
              if (title != null)
                Flexible(
                  child: Center(
                    child: title,
                  ),
                ),
              if (trailing != null)
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: trailing!,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

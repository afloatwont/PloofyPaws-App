import 'package:flutter/material.dart';
import 'package:restoe/config/theme/theme.dart';

class NoDataAvailable extends StatelessWidget {
  final String title;
  final String? body;
  final Widget? image;

  const NoDataAvailable({super.key, required this.title, this.body, this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (image != null) image!,
        const SizedBox(
          height: 16,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: typography(context).title3.copyWith(
                color: colors(context).onSurface.s600,
              ),
        ),
        if (body != null)
          const SizedBox(
            height: 8,
          ),
        if (body != null)
          Text(
            body!,
            textAlign: TextAlign.center,
            style: typography(context).body.copyWith(
                  color: colors(context).onSurface.s400,
                ),
          ),
      ],
    );
  }
}

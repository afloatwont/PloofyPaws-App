import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ploofypaws/config/theme/theme.dart';

class AdaptiveLoading extends StatelessWidget {
  const AdaptiveLoading({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return const SizedBox(width: 30, height: 30, child: Center(child: CircularProgressIndicator()));
    }
    return const CupertinoActivityIndicator(
      color: primary,
    );
  }
}

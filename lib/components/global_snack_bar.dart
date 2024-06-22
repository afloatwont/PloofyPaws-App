import 'package:flutter/material.dart';
import 'package:ploofypaws/config/theme/theme.dart';

enum SnackBarType {
  success,
  error,
  info,
  warning,
}

class GlobalSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    SnackBarType type = SnackBarType.info,
    bool isFloating = false,
  }) {
    if (message.isEmpty) {
      return;
    }

    final snackBar =
        isFloating ? _buildFloatingSnackBar(message, type, context) : _buildTopSnackBar(message, type, context);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static SnackBar _buildTopSnackBar(String message, SnackBarType type, BuildContext context) {
    Color backgroundColor;
    IconData icon;
    switch (type) {
      case SnackBarType.success:
        backgroundColor = colors(context).success.s500;
        icon = Icons.check;
        break;
      case SnackBarType.error:
        backgroundColor = colors(context).critical.s500;
        icon = Icons.error_outline;
        break;
      case SnackBarType.info:
        backgroundColor = colors(context).common.black!.s500;
        icon = Icons.info_outline;
        break;
      case SnackBarType.warning:
        backgroundColor = colors(context).critical.s500;
        icon = Icons.warning;
        break;
    }

    return SnackBar(
      duration: const Duration(seconds: 3),
      backgroundColor: backgroundColor,
      content: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: typography(context).smallBody.copyWith(color: Colors.white),
            ),
          ),
          TextButton(
            child: Text(
              'Dismiss',
              style: typography(context).smallBody.copyWith(color: Colors.white),
            ),
            onPressed: () => _dismissSnackBar(context),
          ),
        ],
      ),
    );
  }

  static SnackBar _buildFloatingSnackBar(String message, SnackBarType type, BuildContext context) {
    Color backgroundColor;

    IconData icon;
    switch (type) {
      case SnackBarType.success:
        backgroundColor = colors(context).success.s500;
        icon = Icons.check;
        break;
      case SnackBarType.error:
        backgroundColor = colors(context).critical.s500;
        icon = Icons.error_outline;
        break;
      case SnackBarType.info:
        backgroundColor = colors(context).primary.s500;
        icon = Icons.info_outline;
        break;
      case SnackBarType.warning:
        backgroundColor = colors(context).critical.s500;
        icon = Icons.warning;
        break;
    }

    return SnackBar(
      duration: const Duration(seconds: 3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      backgroundColor: backgroundColor,
      content: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(width: 8),
          Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  static void _dismissSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}

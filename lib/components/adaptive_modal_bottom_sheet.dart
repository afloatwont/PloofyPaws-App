import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future<T?> showAdaptiveModalBottomSheet<T>({
  required BuildContext context,
  required Widget Function(BuildContext) builder,
  Color? backgroundColor,
  double? elevation,
  ShapeBorder? shape,
  Clip? clipBehavior,
  Color? barrierColor,
  bool expand = false,
  AnimationController? secondAnimation,
  Curve? animationCurve,
  Curve? previousRouteAnimationCurve,
  bool useRootNavigator = false,
  bool bounce = true,
  bool? isDismissible,
  bool enableDrag = true,
  Duration? duration,
  RouteSettings? settings,
  Color? transitionBackgroundColor,
  BoxShadow? shadow,
  bool? showDragHandle,
  SystemUiOverlayStyle? overlayStyle,
  double? closeProgressThreshold,
}) {
  if (Platform.isIOS) {
    return CupertinoScaffold.showCupertinoModalBottomSheet<T>(
      context: context,
      builder: (context) {
        return Column(
          children: [
            if (showDragHandle == true) ...[
              const SizedBox(height: 16),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
            Expanded(child: builder(context)),
          ],
        );
      },
      backgroundColor: backgroundColor,
      barrierColor: barrierColor,
      expand: expand,
      animationCurve: animationCurve,
      previousRouteAnimationCurve: previousRouteAnimationCurve,
      useRootNavigator: useRootNavigator,
      bounce: bounce,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      duration: duration,
      settings: settings,
      shadow: shadow,
      closeProgressThreshold: closeProgressThreshold,
    );
  }
  return showBarModalBottomSheet<T>(
    context: context,
    builder: (context) {
      return Column(
        children: [
          if (showDragHandle == true) ...[
            const SizedBox(height: 16),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
          Expanded(child: builder(context)),
        ],
      );
    },
    backgroundColor: backgroundColor,
    elevation: elevation,
    shape: shape,
    clipBehavior: clipBehavior,
    expand: expand,
    secondAnimation: secondAnimation,
    animationCurve: animationCurve,
    useRootNavigator: useRootNavigator,
    bounce: bounce,
    isDismissible: isDismissible ?? expand == false ? true : false,
    topControl: Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Container(
          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: Icon(Icons.close),
          ),
        ),
      ),
    ),
    enableDrag: enableDrag,
    duration: duration,
    settings: settings,
    closeProgressThreshold: closeProgressThreshold,
  );
}

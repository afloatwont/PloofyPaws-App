import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as modal_bottom_sheet;

class AvatarBottomSheet extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;
  final SystemUiOverlayStyle? overlayStyle;
  final Widget? avatar;

  const AvatarBottomSheet({super.key, required this.child, required this.animation, this.overlayStyle, this.avatar});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle ?? SystemUiOverlayStyle.light,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          SafeArea(
            bottom: false,
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, child) => Transform.translate(
                  offset: Offset(0, (1 - animation.value) * 100),
                  child: Opacity(opacity: max(0, animation.value * 2 - 1), child: child)),
              child: Row(
                children: <Widget>[
                  const SizedBox(width: 20),
                  avatar ??
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey,
                      ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Flexible(
            flex: 1,
            fit: FlexFit.loose,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black12,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                width: double.infinity,
                child: MediaQuery.removePadding(context: context, removeTop: true, child: child),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<T?> showAvatarModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Color? backgroundColor,
  double? elevation,
  ShapeBorder? shape,
  Clip? clipBehavior,
  Color barrierColor = Colors.black87,
  bool bounce = true,
  bool expand = false,
  AnimationController? secondAnimation,
  bool useRootNavigator = false,
  bool isDismissible = true,
  bool enableDrag = true,
  Duration? duration,
  Widget? avatar,
  SystemUiOverlayStyle? overlayStyle,
}) async {
  assert(debugCheckHasMediaQuery(context));
  assert(debugCheckHasMaterialLocalizations(context));
  final result =
      await Navigator.of(context, rootNavigator: useRootNavigator).push(modal_bottom_sheet.ModalSheetRoute<T>(
    builder: builder,
    containerBuilder: (_, animation, child) => AvatarBottomSheet(
      animation: animation,
      overlayStyle: overlayStyle,
      avatar: avatar,
      child: child,
    ),
    bounce: bounce,
    secondAnimationController: secondAnimation,
    expanded: expand,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    isDismissible: isDismissible,
    modalBarrierColor: barrierColor,
    enableDrag: enableDrag,
    duration: duration,
  ));
  return result;
}

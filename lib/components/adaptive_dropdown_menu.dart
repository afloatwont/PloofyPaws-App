import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:ploofypaws/config/theme/theme.dart';

class AdaptiveMenuOption<T> {
  const AdaptiveMenuOption({
    // iOS
    // required this.onTap,
    required this.title,
    this.icon,
    // this.itemTheme,
    // this.iconColor,
    // this.iconWidget,
    this.isDestructive = false,

    // Android
    this.value,
    // this.onTap,
    this.enabled = true,
    // this.height = kMinInteractiveDimension,
    // this.padding,
    // this.textStyle,
    // this.labelTextStyle,
    // this.mouseCursor,
    // required this.child,
  });

  final T? value;
  final String title;
  final bool isDestructive;
  final bool enabled;
  final IconData? icon;
}

class AdaptiveDropdownMenu<T> extends StatefulWidget {
  final List<AdaptiveMenuOption<T>> options;
  final void Function(AdaptiveMenuOption<T> value) onTap;
  final Widget child;

  final PullDownMenuPosition position;
  final PullDownMenuAnchor? buttonAnchor;

  const AdaptiveDropdownMenu({
    super.key,
    required this.options,
    required this.onTap,
    this.position = PullDownMenuPosition.automatic,
    this.buttonAnchor,
    required this.child,
  });

  @override
  State<AdaptiveDropdownMenu<T>> createState() => _AdaptiveDropdownMenuState<T>();
}

class _AdaptiveDropdownMenuState<T> extends State<AdaptiveDropdownMenu<T>> {
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return PopupMenuButton(
        itemBuilder: (context) {
          return widget.options
              .map(
                (option) => PopupMenuItem(
                  enabled: option.enabled,
                  value: option,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        option.title,
                        style: option.isDestructive
                            ? typography(context).smallBody.copyWith(color: colors(context).critical.s500)
                            : typography(context).smallBody,
                      ),
                      if (option.icon != null)
                        Icon(
                          option.icon,
                          color:
                              option.isDestructive ? colors(context).critical.s500 : colors(context).common.black?.s500,
                        ),
                    ],
                  ),
                ),
              )
              .toList();
        },
        onSelected: (option) {
          widget.onTap(option);
        },
        child: widget.child,
      );
    }

    if (Platform.isIOS) {
      return PullDownButton(
        buttonAnchor: widget.buttonAnchor,
        position: widget.position,
        itemBuilder: (context) => widget.options
            .map(
              (option) => PullDownMenuItem(
                icon: option.icon,
                enabled: option.enabled,
                isDestructive: option.isDestructive,
                onTap: () {
                  widget.onTap(option);
                },
                title: option.title,
                itemTheme: PullDownMenuItemTheme(textStyle: typography(context).body.copyWith(fontSize: 15)),
              ),
            )
            .toList(),
        buttonBuilder: (context, showMenu) => GestureDetector(
          onTap: showMenu,
          child: widget.child,
        ),
      );
    }
    return const SizedBox.shrink();
  }
}

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveAppBar extends StatelessWidget {
  final CupertinoNavigationBar? cupertinoNavigationBar;
  final AppBar? materialAppBar;
  final Widget? title;
  final Widget? trailing;
  final String? previousPageTitle;
  final bool automaticallyImplyLeading;
  final Widget? leading;
  final Widget? bottom;

  const AdaptiveAppBar({
    super.key,
    this.title,
    this.trailing,
    this.automaticallyImplyLeading = true,
    this.cupertinoNavigationBar,
    this.materialAppBar,
    this.bottom,
    this.previousPageTitle = 'Back',
    this.leading,
  });

  CupertinoNavigationBar getCupertinoBar() {
    return cupertinoNavigationBar ??
        CupertinoNavigationBar(
          previousPageTitle: previousPageTitle,
          transitionBetweenRoutes: false,
          middle: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              title!,
              const SizedBox(height: 4), // Add spacing between title and bottom widget
              if (bottom != null) bottom!,
            ],
          ),
          trailing: trailing,
          automaticallyImplyLeading: automaticallyImplyLeading,
          leading: leading,
          padding: const EdgeInsetsDirectional.only(start: 0),
        );
  }

  AppBar getMaterialBar() {
    return materialAppBar ??
        AppBar(
          title: title,
          actions: trailing != null ? [Padding(padding: const EdgeInsets.only(right: 8), child: trailing!)] : null,
          leading: leading,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: bottom ?? const SizedBox(),
          ),
          automaticallyImplyLeading: automaticallyImplyLeading,
        );
  }

  @override
  Widget build(BuildContext context) {
    if (title == null && (cupertinoNavigationBar == null || materialAppBar == null)) {
      throw Exception('title cannot be supplied when navigation bars are explicity');
    }

    if (Platform.isIOS) {
      return getCupertinoBar();
    }

    return getMaterialBar();
  }
}

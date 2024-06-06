import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restoe/components/adaptive_app_bar.dart';

class AdaptivePageScaffold extends StatelessWidget {
  final Widget body;
  final Widget? title;
  final AdaptiveAppBar? appBar;
  final bool cupertinoSafeAreaBottom;
  final Widget? bottomNavigationBar;
  final bool? resizeToAvoidBottomInset;
  final bool automaticallyImplyLeading;
  final String? previousPageTitle;
  final Widget? floatingActionButton;
  final Color? appBarColor;
  final IconThemeData? appBarIconTheme;
  final PreferredSize? appBarBottom;
  final Widget? appBarTrailing;
  final Widget? drawer;
  final bool? centertitle;

  const AdaptivePageScaffold({
    this.cupertinoSafeAreaBottom = false,
    this.appBar,
    this.title,
    this.appBarColor,
    this.appBarIconTheme,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset,
    this.automaticallyImplyLeading = true,
    this.floatingActionButton,
    this.appBarBottom,
    this.appBarTrailing,
    this.drawer,
    this.previousPageTitle = 'Back',
    required this.body,
    super.key, this.centertitle,
  });

  @override
  Widget build(BuildContext context) {
    assert(appBar == null || title == null,
        'appBar and title cannot be specified together');

    if (Platform.isIOS) {
      return Scaffold(
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
        drawer: drawer,
        body: CupertinoPageScaffold(
          navigationBar: appBar?.getCupertinoBar() ??
              CupertinoNavigationBar(
                middle: title,
                backgroundColor: appBarColor,
                transitionBetweenRoutes: false,
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: appBarTrailing,
                ),
                automaticallyImplyLeading: automaticallyImplyLeading,
                previousPageTitle: previousPageTitle,
              ),
          resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? false,
          child: SafeArea(
              bottom: cupertinoSafeAreaBottom,
              child: Column(
                children: [
                  if (appBarBottom != null) appBarBottom!,
                  Expanded(child: body),
                ],
              )),
        ),
      );
    }

    return Scaffold(
      drawer: drawer,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      appBar: appBar?.getMaterialBar() ??
          AppBar(
            automaticallyImplyLeading: automaticallyImplyLeading,
            title: title,
            centerTitle: centertitle,
            backgroundColor: appBarColor,
            iconTheme: appBarIconTheme,
            bottom: appBarBottom,
            actions: appBarTrailing != null
                ? [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: appBarTrailing!,
                    )
                  ]
                : null,
          ),
      body: body,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }
}
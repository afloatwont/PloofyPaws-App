import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ploofypaws/pages/root/platform_app_bar.dart';

const title = Text('Track');

class TrackerAppBar implements PlatformAppBar {
  @override
  PreferredSizeWidget android(BuildContext context) {
    return AppBar(
      title: title,
      automaticallyImplyLeading: false,
    );
  }

  @override
  Widget ios(BuildContext context) {
    return const CupertinoSliverNavigationBar(
      backgroundColor: Colors.white,
      largeTitle: title,
    );
  }
}

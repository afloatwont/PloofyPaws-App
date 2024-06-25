import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ploofypaws/pages/root/platform_app_bar.dart';

const title = Text('Home', style: TextStyle(letterSpacing: -1));

class HomeAppBar implements PlatformAppBar {
  @override
  PreferredSizeWidget android(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(7),
        child: Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.black, // Border color
              width: 0.3, // Border width
            ),
          ),
          child: IconButton(
            onPressed: () {
              // Scaffold.of(context).openDrawer();
            },
            icon:
                const Icon(Icons.menu), // Ensuring the icon size is appropriate
          ),
        ),
      ),
      title: title,
      automaticallyImplyLeading: false,
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Container(
            width: 50, // Width and height of the Container
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black, // Border color
                width: 0.3, // Border width
              ),
            ),
            child: const CircleAvatar(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.black,
                child: Icon(Icons.notifications_outlined)),
          ),
        ),
      ],
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

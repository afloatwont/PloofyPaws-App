import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ploofypaws/components/button.dart';
import 'package:ploofypaws/pages/profile/pet_profile/profile.dart';
import 'package:ploofypaws/pages/root/platform_app_bar.dart';

const title = Text('Your Pets');

class ProfileAppBar implements PlatformAppBar {
  @override
  PreferredSizeWidget android(BuildContext context) {
    return AppBar(
      toolbarHeight: 60,
      title: title,
      actions: [
        Button(
            onPressed: () {
              CupertinoScaffold.showCupertinoModalBottomSheet(
                  expand: false, context: context, builder: (context) => const ModalFit());
            },
            variant: 'text',
            buttonIcon: const Icon(Iconsax.user_edit))
      ],
    );
  }

  @override
  Widget ios(BuildContext context) {
    return CupertinoSliverNavigationBar(
      backgroundColor: Colors.white,
      largeTitle: title,
      trailing: Button(
        onPressed: () {
          CupertinoScaffold.showCupertinoModalBottomSheet(
              expand: false, context: context, builder: (context) => const ModalFit());
        },
        variant: 'text',
        buttonIcon: const Icon(Iconsax.user_edit),
      ),
    );
  }
}

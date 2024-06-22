import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ploofypaws/components/adaptive_loading.dart';
import 'package:ploofypaws/components/adaptive_page_scaffold.dart';
import 'package:ploofypaws/components/avatar_modal_sheet.dart';
import 'package:ploofypaws/components/user_avatar.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/pages/profile/app_settings/profile_settings.dart';
import 'package:ploofypaws/pages/root/init_app.dart';
import 'package:ploofypaws/pages/root/provider.dart';
import 'package:ploofypaws/services/repositories/auth/auth.dart';
import 'package:ploofypaws/services/repositories/auth/model.dart' as models;
import 'package:shared_preferences/shared_preferences.dart';

class AccountSettings extends ConsumerStatefulWidget {
  const AccountSettings({super.key});

  @override
  ConsumerState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends ConsumerState<AccountSettings> {
  void signOut() async {
    final authRepo = AuthRepository();
    final storage = await SharedPreferences.getInstance();
    storage.remove('auth');

    authRepo.googleSignOut();

    if (!mounted) return;

    Navigator.of(context)
        .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const InitApp()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<models.UserData?> userInfo = ref.watch(profileProvider);
    return AdaptivePageScaffold(
        body: userInfo.when(
      loading: () => const Center(child: AdaptiveLoading()),
      error: (error, stack) => Center(child: Text('Error: $error')),
      data: (userData) => _buildAccountSettings(userData, context),
    ));
  }

  Widget _buildAccountSettings(models.UserData? userData, BuildContext context) {
    return ListView(children: [
      _buildUserTile(userData),
      ListTile(
        onTap: signOut,
        title: const Text(
          'Sign out',
          style: TextStyle(color: Colors.red),
        ),
      ),
    ]);
  }

  Widget _buildUserTile(models.UserData? userData) {
    return ListTile(
      leading: UserAvatar(
        url: userData?.photoUrl,
        radius: 20,
      ),
      title: Text(
        ' ${userData?.displayName ?? 'Random'}',
        style: typography(context).body.copyWith(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        userData?.email ?? '123@gmail.com',
        style: typography(context)
            .smallBody
            .copyWith(fontWeight: FontWeight.w500, fontSize: 14, color: colors(context).onSurface.s500),
      ),
      onTap: () {
        showAvatarModalBottomSheet(
          expand: true,
          context: context,
          backgroundColor: Colors.transparent,
          avatar: UserAvatar(
            url: userData?.photoUrl,
            radius: 40,
          ),
          builder: (context) => const ProfileSettings(),
        );
      },
      trailing: const Icon(Iconsax.edit, size: 18),
    );
  }
}

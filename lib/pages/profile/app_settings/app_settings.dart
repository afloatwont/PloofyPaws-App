import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ploofypaws/components/adaptive_page_scaffold.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/pages/profile/app_settings/account_settings/accounts.dart';
import 'package:ploofypaws/pages/profile/app_settings/notification/notifications.dart';

class AppSettings extends ConsumerStatefulWidget {
  const AppSettings({super.key});

  @override
  ConsumerState createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<AppSettings> {
  @override
  Widget build(BuildContext context) {
    return AdaptivePageScaffold(
      title: const Text('Settings'),
      body: _buildProfile(context),
    );
  }

  Widget _buildProfile(BuildContext context) {
    return ListView(
      children: [
        _buildInputLabel('Account Settings'),
        _buildListTile(
          leading: Iconsax.user,
          title: 'Account Settings',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AccountSettings()),
            );
          },
        ),
        _buildListTile(
          leading: Iconsax.lovely4,
          title: 'Your pets',
          subtitle: 'Add or remove your pets',
          onTap: () {},
        ),
        _buildInputLabel('Notifications'),
        _buildListTile(
          leading: Iconsax.notification,
          title: 'Notification Settings',
          subtitle: 'Customize your notification settings',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotificationSettings()),
            );
          },
        ),
        _buildInputLabel('Support'),
        _buildListTile(
          leading: Iconsax.link,
          title: 'Help Center',
        ),
        _buildInputLabel('About'),
        _buildListTile(
          leading: Iconsax.star,
          title: 'Rate Us',
        ),
        _buildListTile(
          leading: Iconsax.link1,
          title: 'Privacy Policy',
          onTap: () {},
          trailing: Iconsax.link_214,
        ),
        _buildListTile(
          leading: Iconsax.link1,
          title: 'Terms & Conditions',
          onTap: () {},
          trailing: Iconsax.link_214,
        ),
        _buildListTile(
          leading: Iconsax.support,
          title: 'Contact Us',
          onTap: () {},
        ),
        const SizedBox(height: 16),
        _buildVersionInfo(context),
      ],
    );
  }

  Widget _buildListTile(
      {required String title, String? subtitle, VoidCallback? onTap, IconData? leading, IconData? trailing}) {
    return Padding(
      padding: EdgeInsets.zero,
      child: ListTile(
        leading: leading != null
            ? Icon(
                leading,
                size: 18,
              )
            : null,
        title: Text(
          title,
          style: typography(context).smallBody,
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: typography(context).smallBody.copyWith(color: colors(context).onSurface.s500, fontSize: 14),
              )
            : null,
        onTap: onTap,
        trailing: trailing != null
            ? Icon(
                trailing,
                size: 18,
              )
            : null,
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        label,
        style: typography(context).smallBody.copyWith(color: colors(context).onSurface.s500),
      ),
    );
  }

  Widget _buildVersionInfo(BuildContext context) {
    return Column(
      children: [
        Text(
          'PloofyPaws',
          style: typography(context).ploofypawsTitle.copyWith(color: colors(context).primary.s100, fontSize: 14),
        ),
        Text(
          'Version 1.0.0',
          style: typography(context).smallBody.copyWith(color: colors(context).onSurface.s400),
        ),
      ],
    );
  }
}

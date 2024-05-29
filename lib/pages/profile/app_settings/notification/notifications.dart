import 'package:flutter/material.dart';
import 'package:restoe/components/adaptive_page_scaffold.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  bool trackingNotification = false;

  @override
  Widget build(BuildContext context) {
    return AdaptivePageScaffold(
        title: const Text('Notification Settings'),
        body: ListView(
          children: [
            SwitchListTile.adaptive(
                value: trackingNotification,
                onChanged: (value) {
                  setState(() {
                    trackingNotification = value;
                  });
                },
                title: const Text('Tracking Notification')),
          ],
        ));
  }
}

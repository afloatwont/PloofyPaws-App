import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ploofypaws/pages/tracker/permissions/bluetooth_connectivity_android.dart';

class DeveloperMode extends StatefulWidget {
  const DeveloperMode({super.key});

  @override
  State<DeveloperMode> createState() => _DeveloperModeState();
}

class _DeveloperModeState extends State<DeveloperMode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListTile(
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute<void>(
          builder: (BuildContext context) => const BluetoothAndroidInstructions(),
        ));
      },
      title: const Text('Pet Onboard'),
    ));
  }
}

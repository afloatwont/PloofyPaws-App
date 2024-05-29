import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:restoe/components/adaptive_modal_bottom_sheet.dart';
import 'package:restoe/components/adaptive_page_scaffold.dart';
import 'package:restoe/components/button.dart';
import 'package:restoe/components/input_label.dart';
import 'package:restoe/config/theme/theme.dart';
import 'package:restoe/pages/tracker/pairing_mode/device_id_pairing.dart';
import 'package:restoe/pages/tracker/pairing_mode/nearby_pairing.dart';
import 'package:restoe/pages/tracker/pairing_mode/qr_code_pairing.dart';
import 'package:restoe/pages/tracker/permissions/bluetooth_connectivity.dart';
import 'package:restoe/pages/tracker/permissions/bluetooth_connectivity_android.dart';

class TrackerPairingMode extends StatefulWidget {
  const TrackerPairingMode({super.key});

  @override
  State<TrackerPairingMode> createState() => _TrackerPairingModeState();
}

class _TrackerPairingModeState extends State<TrackerPairingMode> {
  bool _isBlinking = false;

  //sample
  bool isBluetoothEnabled = true;

  showBluetoothEnableInstructionSheet() {
    showAdaptiveModalBottomSheet(
        expand: false,
        context: context,
        builder: (context) {
          if (Platform.isAndroid) {
            return const BluetoothAndroidInstructions();
          } else {
            return const BluetoothIosInstruction();
          }
        });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AdaptivePageScaffold(
        title: const Text(' Pair your restoe device'),
        appBarTrailing: Button(
            variant: 'text',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SelectPairingMode()));
            },
            buttonIcon: const Icon(
              Iconsax.more,
              color: Colors.black,
            )),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CheckboxListTile(
                value: _isBlinking,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) => setState(() => _isBlinking = value!),
                title: const Text("Confirm the light has flashed or breathed")),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Button(
                disabled: !_isBlinking,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const NearbyPairing()));
                },
                label: "Next",
                variant: 'filled',
                buttonColor: Colors.black,
              ),
            ),
          ],
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    margin: EdgeInsets.zero,
                    elevation: 0,
                    color: Colors.grey[100],
                    child: ListTile(
                      title: const Text("Turn on Bluetooth"),
                      onTap: () {
                        showBluetoothEnableInstructionSheet();
                      },
                      trailing: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(Icons.bluetooth_disabled),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text("Make Sure your restoe tracker is on", style: typography(context).strongSmallBody),
                  const SizedBox(height: 8),
                  Text("Tap power button on tracker you want to activate. You should hear a beep and see the led flash",
                      style: typography(context).smallBody),
                  const SizedBox(height: 16),
                  Text("If not, press and hold power button until on.",
                      style: typography(context).strongSmallBody.copyWith(color: colors(context).primary.s500)),
                ],
              ),
            )
          ],
        ));
  }
}

class SelectPairingMode extends StatelessWidget {
  const SelectPairingMode({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptivePageScaffold(
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputLabel(
                  label: "Pairing Mode",
                  size: 32,
                ),
                SizedBox(height: 8),
                InputLabel(
                  label: "Please select the pairing mode to pair your restoe device",
                  size: 16,
                ),
              ],
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.all(16.0),
            title: Text("Scan QR Code", style: typography(context).strong),
            subtitle: Text("Scan the QR code on the back of your restoe device", style: typography(context).smallBody),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const DeviceQRParing()));
            },
            trailing: const Icon(
              Iconsax.scan_barcode,
            ),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 1.00,
            height: 0,
          ),
          ListTile(
            contentPadding: const EdgeInsets.all(16.0),
            title: Text("Enter Device ID", style: typography(context).strong),
            subtitle:
                Text("Enter the device ID manually to pair your restoe device", style: typography(context).smallBody),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const DeviceIDPairing()));
            },
            trailing: const Icon(Iconsax.keyboard),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 1.00,
            height: 0,
          ),
        ],
      ),
    );
  }
}

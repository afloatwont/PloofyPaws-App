import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:restoe/components/adaptive_page_scaffold.dart';
import 'package:restoe/components/body_with_action.dart';
import 'package:restoe/components/button.dart';
import 'package:restoe/components/otp_text_field.dart';
import 'package:restoe/config/theme/theme.dart';
import 'package:restoe/pages/tracker/pairing_mode/qr_code_pairing.dart';

class DeviceIDPairing extends StatefulWidget {
  const DeviceIDPairing({super.key});

  @override
  State<DeviceIDPairing> createState() => _DeviceIDPairingState();
}

class _DeviceIDPairingState extends State<DeviceIDPairing> {
  final otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AdaptivePageScaffold(
        title: const Text('Enter Device Code'),
        appBarTrailing: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Button(
              variant: 'text',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DeviceQRParing()));
              },
              buttonIcon: const Icon(
                Iconsax.scan_barcode,
                color: Colors.black,
              )),
        ),
        body: BodyWithAction(
            body: [
              Text(
                "You can find 6-digit tracker code on the back of your toe-tracker device",
                textAlign: TextAlign.center,
                style: typography(context).strongSmallBody,
              ),
              //Image of the device
              // Image.asset(
              //   'assets/images/tracker.png',
              //   width: 200,
              //   height: 200,
              // ),
              const SizedBox(height: 16),
              OtpTextField(buildContext: context, otpController: otpController),
            ],
            action: Button(
              onPressed: () {},
              variant: 'filled',
              label: 'Activate',
              buttonColor: Colors.black,
            )));
  }
}

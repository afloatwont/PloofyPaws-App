import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ploofypaws/components/adaptive_modal_bottom_sheet.dart';
import 'package:ploofypaws/components/adaptive_page_scaffold.dart';
import 'package:ploofypaws/components/body_with_action.dart';
import 'package:ploofypaws/components/button.dart';
import 'package:ploofypaws/components/countdown_timer.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/pages/tracker/device_found.dart';
import 'package:ploofypaws/pages/tracker/pairing_mode/pairing_instructions.dart';
import 'package:ploofypaws/pages/tracker/widgets/nearby_rings_painter.dart';

class NearbyPairing extends StatefulWidget {
  const NearbyPairing({super.key});

  @override
  State<NearbyPairing> createState() => _NearbyPairingState();
}

class _NearbyPairingState extends State<NearbyPairing> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _showNoDevicesFound = false;
  bool _deviceFound = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showNoDevicesFoundPage() {
    if (!_deviceFound) {
      // Only show no devices found if no device is found
      setState(() {
        _showNoDevicesFound = true;
      });
    }
  }

  _simulateDeviceDiscovery() {
    // Simulate device discovery
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      setState(() {
        _deviceFound = true;
      });
      // Navigate to the DevicesFoundScreen
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DeviceFound()));
    });
  }

  @override
  Widget build(BuildContext context) {
    _simulateDeviceDiscovery();
    return AdaptivePageScaffold(
      title: const Text("Pairing"),
      body: BodyWithAction(
        body: _showNoDevicesFound ? _buildNoDevicesFound(context) : _buildSearching(context),
        action: _buildAction(context),
      ),
    );
  }

  _buildSearching(BuildContext context) {
    return [
      const SizedBox(height: 32),
      Text("Searching for nearby devices...", textAlign: TextAlign.center, style: typography(context).strongSmallBody),
      const SizedBox(height: 16),
      Text("Make sure your Restoe GPS tracker is in the range and the bluetooth is enabled.",
          textAlign: TextAlign.center, style: typography(context).smallBody),
      const SizedBox(height: 64),
      Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            painter: RingPainter(_animation),
            child: SizedBox(
              width: double.infinity,
              height: 300,
              child: Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors(context).primary.s500,
                  ),
                  child: CountDownTimer(
                    secondsRemaining: 200,
                    countDownTimerStyle: typography(context).strong.copyWith(color: Colors.white),
                    whenTimeExpires: _showNoDevicesFoundPage,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ];
  }

  _buildNoDevicesFound(BuildContext context) {
    return [
      Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            ListTile(
              title: Text("No devices found", style: typography(context).strong),
              subtitle: Text("Make sure your Restoe GPS tracker is in the range and the bluetooth is enabled.",
                  style: typography(context).smallBody),
              trailing: const Icon(Iconsax.info_circle5, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Button(
                onPressed: () {
                  setState(() {
                    _showNoDevicesFound = false;
                    _controller.repeat();
                  });
                },
                variant: 'filled',
                label: "Retry",
                buttonIcon: const Icon(Iconsax.refresh),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  Widget _buildAction(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Can't Setup your device?"),
          const SizedBox(width: 8),
          InkWell(
            onTap: () {
              showAdaptiveModalBottomSheet(context: context, builder: (context) => const PairingInstructionsSheet());
            },
            child: Text("Check Instructions",
                style: typography(context)
                    .strongSmallBody
                    .copyWith(decoration: TextDecoration.underline, color: colors(context).primary.s500)),
          ),
        ],
      ),
    );
  }
}

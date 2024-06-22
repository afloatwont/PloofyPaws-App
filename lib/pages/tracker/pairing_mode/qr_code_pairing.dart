import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/pages/tracker/device_found.dart';

class DeviceQRParing extends StatefulWidget {
  const DeviceQRParing({super.key});

  @override
  State<DeviceQRParing> createState() => _DeviceQRParingState();
}

class _DeviceQRParingState extends State<DeviceQRParing> with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  final MobileScannerController _qrController = MobileScannerController();
  late AnimationController _animationController;
  late Animation<double> _animation;
  StreamSubscription<Object?>? _subscription;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // If the controller is not ready, do not try to start or stop it.
    // Permission dialogs can trigger lifecycle changes before the controller is ready.
    if (!_qrController.value.isInitialized) {
      return;
    }
    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        // Restart the scanner when the app is resumed.
        // Don't forget to resume listening to the barcode events.
        _subscription = _qrController.barcodes.listen(_handleBarcode);

        unawaited(_qrController.start());
      case AppLifecycleState.inactive:
        // Stop the scanner when the app is paused.
        // Also stop the barcode events subscription.
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(_qrController.stop());
    }
  }

  @override
  void initState() {
    super.initState();
    // Start listening to lifecycle changes.
    WidgetsBinding.instance.addObserver(this);

    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.1, end: 0.9).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Start listening to the barcode events.
    _subscription = _qrController.barcodes.listen(_handleBarcode);

    // Finally, start the scanner itself.
    unawaited(_qrController.start());
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_subscription?.cancel());
    _subscription = null;
    _animationController.dispose();
    super.dispose();
    await _qrController.dispose();
  }

  void _handleBarcode(BarcodeCapture? barcode) {
    // Handle the barcode here.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        MobileScanner(
          controller: _qrController,
          onDetect: (barcode) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DeviceFound()));
          },
          errorBuilder: (error, e, child) {
            return Text("Error: $error, $e");
          },
        ),
        // add a back button
        Positioned(
          top: 60,
          left: 16,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(Icons.keyboard_arrow_left),
              ),
            ),
          ),
        ),

        deviceQRParingOverlay(),
        Positioned(
          bottom: 60,
          left: 50,
          right: 50,
          child: GestureDetector(
            onTap: () async {
              await _qrController.toggleTorch();
              setState(() {});
            },
            child: Column(
              children: [
                Text("Align the QR Code for identification",
                    style: typography(context).strongSmallBody.copyWith(
                          color: Colors.white,
                        )),
                const SizedBox(height: 32),
                Container(
                  decoration: BoxDecoration(
                    color: _qrController.value.torchState == TorchState.on ? primary : Colors.white24,
                    shape: BoxShape.circle,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.flash_on,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }

  Widget deviceQRParingOverlay() {
    return Center(
      child: Container(
        width: 250,
        height: 250,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white12, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Positioned(
                  top: _animation.value * 250,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      height: 2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 15,
                            offset: const Offset(0, -1),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

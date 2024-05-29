import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:restoe/components/adaptive_page_scaffold.dart';
import 'package:restoe/components/input_label.dart';
import 'package:restoe/config/theme/theme.dart';

class DeviceFound extends StatefulWidget {
  final BarcodeCapture? barcodeCapture;

  const DeviceFound({super.key, this.barcodeCapture});

  @override
  State<DeviceFound> createState() => _DeviceFoundState();
}

class _DeviceFoundState extends State<DeviceFound> {
  @override
  Widget build(BuildContext context) {
    return AdaptivePageScaffold(
        body: ListView(children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const InputLabel(label: 'Devices found', size: 24),
            ListView.separated(
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    tileColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    title: Text(
                      'Connect',
                      style: typography(context).strongSmallBody.copyWith(color: Colors.white),
                    ),
                    subtitle: Text('Device-id sadjoas212 $index',
                        style: typography(context).smallBody.copyWith(color: Colors.white)),
                    trailing:
                        ProgressRing(percent: 20, backgroundColor: Colors.greenAccent, foregroundColor: Colors.green),
                  );
                }),
            const SizedBox(height: 16),
            //saved devices list view
            const InputLabel(label: 'Saved Devices', size: 24),
            ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Device $index'),
                  );
                }),
          ],
        ),
      )
    ]));
  }
}

class ProgressRing extends StatelessWidget {
  final double percent;
  final Color backgroundColor;
  final Color foregroundColor;

  const ProgressRing({super.key, required this.percent, required this.backgroundColor, required this.foregroundColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.0,
      height: 100.0,
      child: Stack(
        children: [
          CircularProgressIndicator(
            backgroundColor: backgroundColor,
            strokeWidth: 5.0,
            value: percent / 100,
          ),
          Center(
            child: Text(
              '${percent.toStringAsFixed(1)}%',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

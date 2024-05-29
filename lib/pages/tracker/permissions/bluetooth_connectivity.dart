import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restoe/config/theme/theme.dart';

class BluetoothIosInstruction extends StatelessWidget {
  const BluetoothIosInstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(CupertinoIcons.bluetooth),
                Text(
                  'You are advised to enable bluetooth',
                  style: typography(context).strongSmallBody,
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.black,
            thickness: 1.00,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Allow bluetooth permission from app \nsettings',
              style: typography(context).body,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Enabled', style: typography(context).smallBody),
                const SizedBox(width: 4),
                const Icon(
                  Icons.check,
                  color: Colors.green,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Container(
              width: double.infinity,
              height: 120,
              color: Colors.black,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Text('Bluetooth', style: typography(context).strong.copyWith(color: Colors.white)),
                          const Spacer(),
                          CupertinoSwitch(
                            activeColor: colors(context).primary.s500,
                            value: true,
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text('Turn on bluetooth', style: typography(context).strong),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.grey.shade300,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(color: Colors.grey.shade400, shape: BoxShape.circle),
                              child: const Icon(CupertinoIcons.airplane, size: 16, color: Colors.white),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(color: Colors.grey.shade400, shape: BoxShape.circle),
                              child: const Icon(Icons.cell_tower, color: Colors.white, size: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(color: Colors.grey.shade400, shape: BoxShape.circle),
                              child: const Icon(CupertinoIcons.wifi, color: Colors.white, size: 16),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(color: colors(context).primary.s500, shape: BoxShape.circle),
                              child: const Icon(CupertinoIcons.bluetooth, color: Colors.white, size: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

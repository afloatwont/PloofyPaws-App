import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ploofypaws/components/button.dart';
import 'package:ploofypaws/config/theme/theme.dart';

class BluetoothAndroidInstructions extends StatelessWidget {
  const BluetoothAndroidInstructions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          _buildBluetoothAdviceTile(context),
          const Divider(color: Colors.black, thickness: 0.5),
          _buildNearbyDevicesPermissionRow(context),
          _buildDevicesContainer(context),
          const SizedBox(height: 32),
          const Divider(color: Colors.black, thickness: 0.5),
          const SizedBox(height: 16),
          _buildEnableBluetoothText(context),
          const SizedBox(height: 32),
          _buildConnectivityOptions(context),
        ],
      ),
    );
  }

  ListTile _buildBluetoothAdviceTile(BuildContext context) {
    return ListTile(
      title: Text(
        'You are advised to enable bluetooth.',
        style: typography(context).strongSmallBody,
      ),
      subtitle: Text(
        'Enable bluetooth to add some WI-FI devices easily',
        style: typography(context).smallBody.copyWith(fontSize: 10, color: Colors.grey),
      ),
      leading: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: colors(context).primary.s500,
          shape: BoxShape.circle,
        ),
        child: const Icon(CupertinoIcons.bluetooth, color: Colors.white, size: 20),
      ),
    );
  }

  Padding _buildNearbyDevicesPermissionRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Allow "Nearby Devices"\npermission from app',
            style: typography(context).strongSmallBody,
          ),
          const Spacer(),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Button(
              padding: EdgeInsets.zero,
              onPressed: () {},
              variant: "text",
              label: "Go to set",
              buttonIcon: const Icon(Icons.keyboard_arrow_right),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildDevicesContainer(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Devices",
              style: typography(context).title3.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 16),
            _buildDeviceScanContainer(context),
          ],
        ),
      ),
    );
  }

  Container _buildDeviceScanContainer(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white12,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          children: [
            Text(
              "Scan for Nearby Devices",
              style: typography(context).body.copyWith(color: Colors.white),
            ),
            const Spacer(),
            Switch(
              value: true,
              onChanged: (value) {},
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildEnableBluetoothText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'Turn on Bluetooth',
        style: typography(context).strong,
      ),
    );
  }

  Container _buildConnectivityOptions(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
        child: Column(
          children: [
            _buildConnectivityOptionRow(
                context, Icons.network_wifi_3_bar_outlined, "Wi-Fi", Icons.network_cell, "Mobile Data"),
            const SizedBox(height: 8),
            _buildConnectivityOptionRow(
                context, Icons.bluetooth, "Bluetooth", Icons.do_not_disturb_on_outlined, "Do Not Disturb"),
          ],
        ),
      ),
    );
  }

  Row _buildConnectivityOptionRow(BuildContext context, IconData icon1, String text1, IconData icon2, String text2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildConnectivityOption(context, icon1, text1, Colors.white12),
        const SizedBox(width: 16),
        _buildConnectivityOption(context, icon2, text2, Colors.white12),
      ],
    );
  }

  Expanded _buildConnectivityOption(BuildContext context, IconData icon, String text, Color color) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: icon == Icons.bluetooth ? colors(context).primary.s100 : color,
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          leading: Icon(icon, color: icon == Icons.bluetooth ? Colors.black : Colors.white),
          title: Text(
            text,
            style: typography(context).smallBody.copyWith(color: icon == Icons.bluetooth ? Colors.black : Colors.white),
          ),
        ),
      ),
    );
  }
}

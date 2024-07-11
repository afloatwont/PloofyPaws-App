import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ploofypaws/components/adaptive_app_bar.dart';
import 'package:ploofypaws/components/adaptive_page_scaffold.dart';
import 'package:ploofypaws/components/button.dart';
import 'package:ploofypaws/components/gradient_header.dart';
import 'package:ploofypaws/components/gradient_text_icon.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/location/map_location.dart';
import 'package:ploofypaws/pages/root/root.dart';
import 'package:ploofypaws/pages/tracker/pairing.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/providers/user_provider.dart';
import 'package:provider/provider.dart';

class Tracker extends StatefulWidget {
  const Tracker({super.key});

  @override
  State<Tracker> createState() => _TrackerState();
}

class _TrackerState extends State<Tracker> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowAddressModal();
    });
  }

  void _checkAndShowAddressModal() {
    final userProvider = context.read<UserProvider>();
    if (!userProvider.hasAddress()) {
      _showAddressModal();
    }
  }

  void _showAddressModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        // Replace this with your actual modal content
        return const AddAddressSheet();
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return AdaptivePageScaffold(
        appBarBottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: SafeArea(
            child: GradientHeader(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Get your", style: typography(context).smallBody.copyWith(color: Colors.white)),
                    const SizedBox(width: 8),
                    GradientText(
                        text: "Toe Tracker",
                        gradient: LinearGradient(colors: [colors(context).primary.s400, colors(context).warning.s500])),
                    const SizedBox(width: 8),
                    Text("Here", style: typography(context).smallBody.copyWith(color: Colors.white))
                  ],
                ),
                trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.white)),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Button(
            onPressed: () {
              Navigator.push(context, MaterialWithModalsPageRoute(builder: (context) => const TrackerPairingMode()));
            },
            label: "Add Device",
            variant: 'filled',
            buttonIcon: const Icon(Icons.add, color: Colors.white),
          ),
        ),
        body: const Column(
          children: [

          ],
        ));
  }
}
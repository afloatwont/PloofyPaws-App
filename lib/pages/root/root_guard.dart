import 'package:flutter/material.dart';
import 'package:ploofypaws/components/adaptive_loading.dart';
import 'package:ploofypaws/pages/pet_onboarding/pet_onboard.dart';
import 'package:ploofypaws/pages/root/root.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RootGuard extends StatefulWidget {
  const RootGuard({super.key});

  @override
  State<RootGuard> createState() => _RootGuardState();
}

class _RootGuardState extends State<RootGuard> {
  Future<bool> checkPetOnboarding() async {
    final storage = await SharedPreferences.getInstance();
    final rawPetOnboarding = storage.getBool('pet_onboarding');
    if (rawPetOnboarding == null) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkPetOnboarding(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data == false) {
            return const PetOnboarding();
          }
          if (snapshot.hasData && snapshot.data == true) {
            return const Root();
          }

          return const Scaffold(
            body: SafeArea(
              child: Center(child: AdaptiveLoading()),
            ),
          );
        });
  }
}

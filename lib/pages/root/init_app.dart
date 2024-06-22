import 'package:flutter/material.dart';
import 'package:ploofypaws/pages/auth/auth_guard/auth_guard.dart';
import 'package:ploofypaws/pages/onboarding/onboard_carousel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitApp extends StatefulWidget {
  const InitApp({super.key});

  @override
  State<InitApp> createState() => _InitAppState();
}

class _InitAppState extends State<InitApp> {
  bool _shouldSeeOnboarding = false;

  Future<void> checkFirstLaunch() async {
    final SharedPreferences storage = await SharedPreferences.getInstance();

    setState(() {
      _shouldSeeOnboarding = storage.getBool('has_seen_onboarding') != true;
    });
  }

  @override
  void initState() {
    checkFirstLaunch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_shouldSeeOnboarding) {
      return const OnboardingCarousel();
    }

    return const AuthGuard();
  }
}

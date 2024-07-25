import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ploofypaws/pages/auth/sign-in/sign_in.dart';
import 'package:ploofypaws/pages/root/root_guard.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthGuard extends StatefulWidget {
  const AuthGuard({super.key});

  @override
  State<AuthGuard> createState() => _AuthGuardState();
}

class _AuthGuardState extends State<AuthGuard> {
  Future<bool> checkAuth() async {
    final authService = GetIt.instance.get<AuthServices>();
    if (authService.user == null) {
      // Remove the splash screen
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkAuth(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data == false) {
            return const SignInPage();
          }
          if (snapshot.hasData && snapshot.data == true) {
            return const RootGuard();
          }

          return const Scaffold(
            body: SafeArea(
              child: Center(child: CircularProgressIndicator.adaptive()),
            ),
          );
        });
  }
}

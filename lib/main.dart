import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restoe/config/theme/theme.dart';
import 'package:restoe/pages/doctors/about_doctor_page.dart';
import 'package:restoe/pages/pet_onboarding/pet_onboard.dart';
import 'package:restoe/pages/root/init_app.dart';
import 'package:restoe/services/navigation/navigation.dart';

import 'config/theme/placebo_colors.dart';
import 'config/theme/placebo_typography.dart';

void main() {
  GetIt getIt = GetIt.instance;
  getIt.registerLazySingleton<NavigationService>(() => NavigationService());

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'PloofyPaws',
        navigatorKey: GetIt.instance<NavigationService>().navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: themeData.copyWith(
          extensions: <ThemeExtension<dynamic>>[PlaceboColors.light, textTheme],
          textTheme:
              GoogleFonts.poppinsTextTheme().apply(bodyColor: Colors.black),
        ),
        home: const AboutDoctorPage()
        //PetOnboarding()
        );
  }
}

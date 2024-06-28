import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ploofypaws/chat/ChatScreen.dart';
import 'package:ploofypaws/chat/services/database_service.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/location/map_location.dart';
import 'package:ploofypaws/pages/developer/test.dart';
import 'package:ploofypaws/pages/home/home.dart';
import 'package:ploofypaws/pages/home/services/vet_video_consultation.dart';
import 'package:ploofypaws/pages/pet_onboarding/pet_onboard.dart';
import 'package:ploofypaws/pages/profile/pet_life_event/add_media.dart';
import 'package:ploofypaws/pages/profile/pet_life_event/create_pet_memorial.dart';
import 'package:ploofypaws/pages/profile/pet_life_event/memories.dart';
import 'package:ploofypaws/pages/profile/profile.dart';
import 'package:ploofypaws/pages/root/init_app.dart';
import 'package:ploofypaws/pages/root/root.dart';
import 'package:ploofypaws/pages/training/training.dart';
import 'package:ploofypaws/pages/vet_video_consultation/vet_video_consultation.dart';
import 'package:ploofypaws/pet_adoption/adoption_page.dart';
import 'package:ploofypaws/pets_card.dart';
import 'package:ploofypaws/services/navigation/navigation.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_auth.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_store.dart';
import 'firebase_options.dart';
import 'config/theme/placebo_colors.dart';
import 'config/theme/placebo_typography.dart';
import 'location/location.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt getIt = GetIt.instance;
  getIt.registerLazySingleton<NavigationService>(() => NavigationService());
  getIt.registerLazySingleton<ChatDatabaseService>(() => ChatDatabaseService());
  getIt.registerLazySingleton<UserDatabaseService>(() => UserDatabaseService());
  getIt.registerLazySingleton<AuthServices>(() => AuthServices());

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GetIt _getIt = GetIt.instance;
  late AuthServices _authServices;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authServices = _getIt.get<AuthServices>();
  }

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
      home: _authServices.user != null ? const InitApp() : const VetVideoConsultationScreen(),
    );
  }
}

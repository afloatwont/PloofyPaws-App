import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ploofypaws/chat/services/chat_database_service.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/controllers/calender_provider.dart';
import 'package:ploofypaws/controllers/time_provider.dart';
import 'package:ploofypaws/location/map_location.dart';
import 'package:ploofypaws/pages/home/services/pet_walking/selected_plan_provider.dart';
import 'package:ploofypaws/pages/pet_onboarding/pet_onboard.dart';
import 'package:ploofypaws/pages/profile/pet_life_event/memories.dart';
import 'package:ploofypaws/pages/profile/pet_life_event/pet_memories.dart';
import 'package:ploofypaws/pages/root/init_app.dart';
import 'package:ploofypaws/pages/root/root.dart';
import 'package:ploofypaws/services/alert/alert_service.dart';
import 'package:ploofypaws/services/navigation/navigation.dart';
import 'package:ploofypaws/pages/profile/pet_profile/profile.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_auth.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_store.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/user_model.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/user_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'config/theme/placebo_colors.dart';
import 'config/theme/placebo_typography.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  registerServices();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => SelectedPlanProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => TimeProvider()),
      ChangeNotifierProvider(create: (_) => AddressModel()),
      ChangeNotifierProvider(create: (_) => CalendarProvider()),
    ],
    child: const MyApp(),
  ));
}

void registerServices() {
  GetIt getIt = GetIt.instance;
  getIt.registerLazySingleton<NavigationService>(() => NavigationService());
  getIt.registerSingleton<AlertService>(AlertService());
  getIt.registerLazySingleton<AuthServices>(() => AuthServices());
  getIt.registerSingleton<ChatDatabaseService>(ChatDatabaseService());
  getIt.registerSingleton<UserDatabaseService>(UserDatabaseService());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GetIt _getIt = GetIt.instance;
  late AuthServices _authServices;
  late UserDatabaseService _userDatabaseService;
  UserModel currUser = UserModel(
      id: "", displayName: "", email: "", photoUrl: "", address: null);

  @override
  void initState() {
    super.initState();
    _authServices = _getIt.get<AuthServices>();
    _userDatabaseService = _getIt.get<UserDatabaseService>();

    if (_authServices.user != null) {
      _userDatabaseService
          .getUserProfileByUID(_authServices.user!.uid)
          .then((value) {
        setState(() {
          currUser = value!;
        });
        Provider.of<UserProvider>(context, listen: false).setUser(currUser);
      });
    }
    print(_authServices.user);
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
      home:
          _authServices.user != null ? const PetOnboarding() : const InitApp(),
    );
  }
}

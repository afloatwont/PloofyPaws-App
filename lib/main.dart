import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ploofypaws/chat/services/chat_database_service.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/controllers/calender_provider.dart';
import 'package:ploofypaws/controllers/time_provider.dart';
import 'package:ploofypaws/pages/appointment/summary.dart';
import 'package:ploofypaws/pages/home/services/add_diet.dart';
import 'package:ploofypaws/pages/home/services/pet_walking/selected_plan_provider.dart';
import 'package:ploofypaws/pages/root/init_app.dart';
import 'package:ploofypaws/pages/root/root.dart';
import 'package:ploofypaws/services/alert/alert_service.dart';
import 'package:ploofypaws/services/navigation/navigation.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_assets.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_auth.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_store.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/models/address_model.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/models/user_model.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/providers/doctor_provider.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/providers/pet_provider.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/providers/user_provider.dart';
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
      ChangeNotifierProvider(create: (_) => PetProvider()),
      ChangeNotifierProvider(create: (_) => TimeProvider()),
      ChangeNotifierProvider(create: (_) => AddressModel()),
      ChangeNotifierProvider(create: (_) => CalendarProvider()),
      ChangeNotifierProvider(create: (_) => UrlProvider()),
      ChangeNotifierProvider(create: (_) => DietProvider()),
      ChangeNotifierProvider(create: (_) => VeterinaryDoctorProvider()),
      ChangeNotifierProvider(create: (_) => TimeProvider()),
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
  late AlertService _alertService;
  late UserDatabaseService _userDatabaseService;
  UserModel currUser = UserModel(
      id: "", displayName: "", email: "", photoUrl: "", address: null);

  @override
  void initState() {
    super.initState();
    _authServices = _getIt.get<AuthServices>();
    _userDatabaseService = _getIt.get<UserDatabaseService>();
    _alertService = _getIt.get<AlertService>();
    final userProvider = context.read<UserProvider>();
    final petProvider = context.read<PetProvider>();
    // final urlProvider = context.read<UrlProvider>();
    // urlProvider.loadUrlMap().then(
    //   (value) {
    //     setState(() {
    //       urlProvider.preloadUrls().then(
    //             (value) => setState(() {}),
    //           );
    //     });
    //   },
    // );

    if (_authServices.user != null) {
      _userDatabaseService
          .getUserProfileByUID(_authServices.user!.uid)
          .then((value) {
        if (value != null) {
          setState(() {
            currUser = value;
            userProvider.setUser(currUser);
          });
        }
      }).catchError(
        (e) {
          _alertService.showToast(text: e.toString());
        },
      );
      _userDatabaseService
          .getAllPetsForUser(_authServices.user!.uid)
          .then((value) {
        if (value!.isNotEmpty) {
          setState(() {
            print(value[0].name);
            petProvider.setPets(value);
          });
        }
      });
    }
    if (kDebugMode) {
      print(_authServices.user);
    }
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
          _authServices.user != null ? const SummaryScreen() : const InitApp(),
    );
  }
}

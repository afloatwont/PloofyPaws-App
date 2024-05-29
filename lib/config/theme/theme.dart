import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restoe/config/theme/placebo_colors.dart';
import 'package:restoe/config/theme/placebo_typography.dart';

PlaceboColors colors(BuildContext context) {
  if (Platform.isIOS) {
    return PlaceboColors.light;
  }
  return Theme.of(context).extension<PlaceboColors>()!;
}

PlaceboTypography typography(BuildContext context) {
  if (Platform.isIOS) {
    return textTheme;
  }
  return Theme.of(context).extension<PlaceboTypography>()!;
}

const primary = MaterialColor(
  0xFF1A24DE,
  <int, Color>{
    50: Color(0xFFE6E7FF),
    100: Color(0xFFBFC3FF),
    200: Color(0xFF929AFF),
    300: Color(0xFF656AFF),
    400: Color(0xFF3D4CFF),
    500: Color(0xFF1A24DE),
    600: Color(0xFF151EAC),
    700: Color(0xFF10197A),
    800: Color(0xFF0B1248),
    900: Color(0xFF060B16),
  },
);

final ThemeData themeData = ThemeData(
  colorScheme: ColorScheme.fromSwatch(primarySwatch: primary, backgroundColor: Colors.white),
  primaryColor: primary.shade500,
  useMaterial3: true,
  fontFamily: GoogleFonts.poppins().fontFamily,
  scaffoldBackgroundColor: Colors.white,
  typography: Typography.material2021(),
  disabledColor: const Color(0xFF4F4F4F),
  tabBarTheme: TabBarTheme(
    labelStyle: textTheme.body.copyWith(fontWeight: FontWeight.bold),
    unselectedLabelStyle: textTheme.body,
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return primary.shade500;
      }
      return Colors.white;
    }),
    trackColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return primary.shade200;
      }
      return Colors.grey;
    }),
  ),
  datePickerTheme: const DatePickerThemeData(elevation: 0, backgroundColor: Colors.white),
  popupMenuTheme: PopupMenuThemeData(
    color: Colors.white,
    elevation: 0,
    textStyle: textTheme.body,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    helperStyle: textTheme.smallBody,
    hintStyle: textTheme.smallBody.copyWith(
      color: Colors.grey,
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFFCE3E3E), // critical.500
        width: 2,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),

    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFFCE3E3E), // critical.500
        width: 2,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    // constraints: BoxConstraints(maxHeight: 44),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFFB0B0B0),
        width: 1,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFF1A24DE),
        width: 2,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  ),
  appBarTheme: AppBarTheme(
    surfaceTintColor: Colors.transparent,
    // backgroundColor: Colors.white.withOpacity(0.7),
    // This will be applied to the "back" icon
    scrolledUnderElevation: 0,
    iconTheme: const IconThemeData(color: Colors.black),
    // This will be applied to the action icon buttons that locates on the right side
    actionsIconTheme: const IconThemeData(color: Colors.black),
    centerTitle: false,
    elevation: 0,
    titleTextStyle: textTheme.title2,
  ),
  textTheme: const TextTheme(
    // largeTitle ()
    displayLarge: TextStyle(
      color: Colors.black,
      fontSize: 34,
      letterSpacing: -0.68,
      fontWeight: FontWeight.w700,
    ),

    // title1 ()
    displayMedium: TextStyle(
      color: Colors.black,
      fontSize: 28,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.56,
    ),

    // title2 ()
    displaySmall: TextStyle(
      color: Colors.black,
      fontSize: 22,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.44,
    ),

    // title3 ()
    titleLarge: TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.4,
    ),

    // subtitle1 ()
    titleMedium: TextStyle(
      color: Colors.black,
      fontSize: 17,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.34,
    ),

    // subtitle2 ()
    titleSmall: TextStyle(
      color: Colors.black,
      fontSize: 15,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.34,
    ),

    // largeBody ()
    bodyLarge: TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.36,
    ),

    // body ()
    bodyMedium: TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      // letterSpacing: "-0.4px",
    ),

    // smallBody ()
    bodySmall: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      // letterSpacing: "-0.4px",
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: textTheme.body,
      backgroundColor: primary,
      elevation: 0,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(extendedTextStyle: textTheme.body),
);

final ThemeData darkThemeData = ThemeData(
  // backgroundColor: Colors.black,
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.black,
  primaryColor: const Color(0xFF4666F6),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    // This will be applied to the "back" icon
    iconTheme: IconThemeData(color: Colors.white),
    // This will be applied to the action icon buttons that locates on the right side
    actionsIconTheme: IconThemeData(color: Colors.blue),
    centerTitle: false,
    elevation: 0,
    titleTextStyle: TextStyle(color: Colors.lightBlueAccent),
  ),
  // colorScheme: ColorScheme(background: Colors.black),
);

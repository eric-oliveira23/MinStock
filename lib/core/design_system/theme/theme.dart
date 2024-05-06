import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minstock/core/design_system/theme/app_colors.dart';

final darkTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xFF151517),
  primaryColor: const Color(0xFF151517),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: _white),
  fontFamily: GoogleFonts.comfortaa().fontFamily,
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFF151517),
    centerTitle: true,
    titleTextStyle: GoogleFonts.comfortaa(
      textStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    labelStyle: const TextStyle(color: Colors.grey),
    fillColor: AppColors.grey2020,
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
      borderSide: BorderSide.none,
    ),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF004A77)),
      foregroundColor: MaterialStateProperty.all<Color>(
        const Color(0xffffffff),
      ),
    ),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Color(0xFF151517),
    surfaceTintColor: Colors.transparent,
  ),
  textTheme: GoogleFonts.comfortaaTextTheme().copyWith(
    bodyLarge: const TextStyle(color: Colors.white),
    bodyMedium: const TextStyle(color: Colors.white),
  ),
);

final lightTheme = ThemeData(
  primaryColor: AppColors.black1A1E,
  scaffoldBackgroundColor: Colors.white,
  fontFamily: GoogleFonts.comfortaa().fontFamily,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.grey2020,
    centerTitle: true,
  ),
  textTheme: GoogleFonts.comfortaaTextTheme().copyWith(
    bodyLarge: TextStyle(color: AppColors.black1A1E),
    bodyMedium: TextStyle(color: AppColors.black1A1E),
    titleLarge: GoogleFonts.comfortaa(
      textStyle: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
);
const MaterialColor _white = MaterialColor(
  0xFFFFFFFF,
  <int, Color>{
    50: Color(0xFFFFFFFF),
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFFFFF),
    300: Color(0xFFFFFFFF),
    400: Color(0xFFFFFFFF),
    500: Color(0xFFFFFFFF),
    600: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
    800: Color(0xFFFFFFFF),
    900: Color(0xFFFFFFFF),
  },
);

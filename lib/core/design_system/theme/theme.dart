// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minstock/core/design_system/theme/app_colors.dart';

final darkTheme = ThemeData(
  useMaterial3: true,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: const Color(0xFF151517),
  primaryColor: const Color(0xFF151517),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: _white).copyWith(onSecondary: AppColors.grey2020),
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
    prefixIconColor: Colors.white,
    prefixStyle: const TextStyle(color: Colors.white),
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
      backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFF004A77)),
      foregroundColor: WidgetStateProperty.all<Color>(
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
  tabBarTheme: const TabBarTheme(labelColor: Colors.white),
  iconTheme: const IconThemeData(color: Colors.white),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(Colors.white),
    ),
  ),
  primaryIconTheme: const IconThemeData(color: Colors.white),
  listTileTheme: ListTileThemeData(
    tileColor: AppColors.grey2020,
    titleTextStyle: const TextStyle().copyWith(color: Colors.white, fontFamily: GoogleFonts.comfortaa().fontFamily),
  ),
);

// l i g h t

final lightTheme = ThemeData(
  useMaterial3: true,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primaryColor: Colors.white,
  scaffoldBackgroundColor: Colors.grey.shade200,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: _black).copyWith(onSecondary: Colors.grey.shade300),
  fontFamily: GoogleFonts.comfortaa().fontFamily,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    centerTitle: true,
    titleTextStyle: GoogleFonts.comfortaa(
      textStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    labelStyle: const TextStyle(color: Colors.black),
    fillColor: Colors.grey.shade300,
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
      borderSide: BorderSide.none,
    ),
    prefixStyle: const TextStyle(color: Colors.black),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFF004A77)),
      foregroundColor: WidgetStateProperty.all<Color>(
        const Color(0xffffffff),
      ),
    ),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.transparent,
  ),
  textTheme: GoogleFonts.comfortaaTextTheme().copyWith(
    bodyLarge: TextStyle(color: AppColors.black1A1E),
    bodyMedium: TextStyle(color: AppColors.black1A1E),
  ),
  navigationBarTheme: const NavigationBarThemeData(
    indicatorColor: Colors.black,
    backgroundColor: Colors.white,
    iconTheme: MaterialStatePropertyAll(
      IconThemeData(color: Colors.black),
    ),
  ),
  tabBarTheme: const TabBarTheme(labelColor: Colors.black, indicatorColor: Colors.black),
  iconTheme: const IconThemeData(color: Colors.black),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: MaterialStatePropertyAll(Colors.black),
    ),
  ),
  primaryIconTheme: const IconThemeData(color: Colors.black),
  listTileTheme: ListTileThemeData(
    tileColor: Colors.grey.shade300,
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
const MaterialColor _black = MaterialColor(
  0xFF000000,
  <int, Color>{
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(0xFF000000),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);

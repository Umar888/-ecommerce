import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/colors_constants.dart';

final themeLight = ThemeData(
  brightness: Brightness.light,
  textTheme: GoogleFonts.poppinsTextTheme().apply(
    bodyColor: appBackgroundColorDark,
    displayColor: primaryColorDark,
  ),
  primaryColorDark: primaryColorDark,
  primaryColorLight: primaryColorLight,
  primaryColor: primaryColorDark,
  scaffoldBackgroundColor: appBackgroundColor,
  appBarTheme: AppBarTheme(
    color: primaryColorDark,
    centerTitle: true,
    elevation: 10
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: primaryColorDark
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: primaryColorDark,
    selectionColor: primaryColorDark,
    selectionHandleColor: primaryColorDark
  ),
  inputDecorationTheme: InputDecorationTheme(
    isDense: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    focusColor: primaryColorDark,
    floatingLabelStyle: const TextStyle(color: primaryColorDark),
    // focusedBorder: const OutlineInputBorder(
    //   borderSide: BorderSide(color: blueGradientFirstColor),
    // ),
  ),
);
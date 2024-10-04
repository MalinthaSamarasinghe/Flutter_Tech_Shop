import 'constants.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      fontFamily: "Muli",
      appBarTheme: const AppBarTheme(
        color: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: kTextColor),
        bodyMedium: TextStyle(color: kTextColor),
        bodySmall: TextStyle(color: kTextColor),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        border: outlineInputBorder,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 48),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: Colors.black, // Dark background
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      fontFamily: "Muli",
      appBarTheme: const AppBarTheme(
        color: Colors.black, // Dark app bar color
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white), // White icons on dark background
        titleTextStyle: TextStyle(color: Colors.white), // White text
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white70), // Slightly faded white for text
        bodyMedium: TextStyle(color: Colors.white70),
        bodySmall: TextStyle(color: Colors.white70),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white54), // Lighter border color
          borderRadius: BorderRadius.all(Radius.circular(28)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white), // Focused border white
          borderRadius: BorderRadius.all(Radius.circular(28)),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white54), // Regular border color
          borderRadius: BorderRadius.all(Radius.circular(28)),
        ),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: kPrimaryColor, // Same primary color for consistency
          foregroundColor: Colors.black, // Dark foreground (black text on colored button)
          minimumSize: const Size(double.infinity, 48),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
    );
  }
}

const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(28)),
  borderSide: BorderSide(color: kTextColor),
  gapPadding: 10,
);

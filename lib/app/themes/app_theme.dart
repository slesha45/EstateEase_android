import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static getApplicationTheme(bool isDark) {
    return ThemeData(
      // Change the theme according to the user preference
      colorScheme: isDark
          ? const ColorScheme.dark(
              primary: Colors.grey, // Dark theme primary color
            )
          : const ColorScheme.light(
              primary: Colors.brown, // Light theme primary color
            ),
      brightness: isDark ? Brightness.dark : Brightness.light,
      fontFamily: 'Arial', // Use a common font

      // Change app bar color
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: isDark ? Colors.grey : Colors.brown,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),

      // Change elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: isDark ? Colors.grey : Colors.brown,
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),

      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: Colors.white,
        ),
      ),

      // Change text field theme
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(15),
        border: const OutlineInputBorder(),
        labelStyle: const TextStyle(
          fontSize: 20,
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isDark ? Colors.grey : Colors.brown,
          ),
        ),
      ),

      // Circular progress bar theme
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: isDark ? Colors.grey : Colors.brown,
      ),

      // Bottom navigation bar theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: isDark ? Colors.grey : Colors.brown,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }
}

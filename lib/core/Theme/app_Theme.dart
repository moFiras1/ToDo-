import 'package:flutter/material.dart';

class AppTheme {
  static const Color lightPrimaryColor = Color(0xFF5D9CEC);
  static const Color scaffoldBgColor = Color(0xFFDFECDB);
  static const Color grayColor = Color(0xFFC8C9CB);

  static final ThemeData lightTheme = ThemeData(
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 18,
      ),
      colorScheme: ColorScheme.fromSeed(
          seedColor: lightPrimaryColor,
          primary: lightPrimaryColor,
          onPrimary: Colors.white),
      textTheme: TextTheme(
          titleMedium: TextStyle(
              fontSize: 18,
              color: lightPrimaryColor,
              fontWeight: FontWeight.bold),
          titleSmall: TextStyle(
              fontSize: 12, color: Colors.black, fontWeight: FontWeight.normal),
          headlineMedium: TextStyle(
              fontWeight: FontWeight.bold,
              color: lightPrimaryColor,
              fontSize: 18),
          labelMedium: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
      useMaterial3: false,
      primaryColor: lightPrimaryColor,
      appBarTheme: AppBarTheme(
          backgroundColor: lightPrimaryColor,
          titleTextStyle: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 22, color: Colors.white)),
      scaffoldBackgroundColor: scaffoldBgColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: lightPrimaryColor,
        unselectedItemColor: grayColor,
      ));
}

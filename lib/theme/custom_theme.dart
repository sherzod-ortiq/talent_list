import 'package:flutter/material.dart';

import 'custom_color.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.green,
      primaryColor: CustomColor.darkGreen,
      backgroundColor: const Color.fromARGB(171, 97, 97, 97),
      scaffoldBackgroundColor: CustomColor.white,
      cardColor: CustomColor.lightGreen,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: CustomColor.darkGreen,
        onPrimary: CustomColor.white,
        secondary: const Color.fromARGB(255, 66, 192, 20),
        onSecondary: CustomColor.white,
        error: Colors.red,
        onError: Colors.red,
        background: const Color.fromARGB(171, 97, 97, 97),
        onBackground: CustomColor.white,
        surface: Colors.black,
        onSurface: Colors.black,
      ),
      textTheme: ThemeData.light().textTheme.copyWith(
            headline4: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: CustomColor.mainTextColor,
            ),
            headline5: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: CustomColor.mainTextColor,
            ),
            headline6: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: CustomColor.mainTextColor,
            ),
          ),
      appBarTheme: AppBarTheme(
        backgroundColor: CustomColor.darkGreen,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: CustomColor.white,
        ),
      ),
      listTileTheme: ListTileThemeData(
        tileColor: CustomColor.lightGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      dividerTheme: const DividerThemeData(space: 1.0),
      dividerColor: CustomColor.grey,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: const StadiumBorder(),
        foregroundColor: CustomColor.white,
        backgroundColor: CustomColor.darkGreen,
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'custom_color.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.green,
      primaryColor: CustomColor.darkGreen,
      backgroundColor: CustomColor.white,
      scaffoldBackgroundColor: CustomColor.white,
      cardColor: CustomColor.lightGreen,
      // fontFamily: "CustomFont",
      textTheme: ThemeData.light().textTheme.copyWith(
            headline5: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w700,
              color: CustomColor.mainTextColor,
            ),
            headline6: TextStyle(
              fontSize: 19,
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
      tabBarTheme: TabBarTheme(
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 3.1,
            color: CustomColor.black,
          ),
        ),
        unselectedLabelColor: CustomColor.grey,
        unselectedLabelStyle: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w400,
        ),
        labelColor: CustomColor.black,
        labelStyle: const TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w400,
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(
        textStyle: TextStyle(
          color: CustomColor.black,
        ),
        color: CustomColor.lightGreen,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: CustomColor.darkGreen,
          textStyle: TextStyle(
            color: CustomColor.black,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: TextStyle(
            color: CustomColor.black,
          ),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: const StadiumBorder(),
        foregroundColor: CustomColor.black,
        backgroundColor: CustomColor.darkGreen,
      ),
    );
  }
}

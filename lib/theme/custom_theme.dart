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
      // tabBarTheme: TabBarTheme(
      //   indicator: UnderlineTabIndicator(
      //     borderSide: BorderSide(
      //       width: 3.1,
      //       color: CustomColor.black,
      //     ),
      //   ),
      //   unselectedLabelColor: CustomColor.grey,
      //   unselectedLabelStyle: const TextStyle(
      //     fontSize: 17,
      //     fontWeight: FontWeight.w400,
      //   ),
      //   labelColor: CustomColor.black,
      //   labelStyle: const TextStyle(
      //     fontSize: 19,
      //     fontWeight: FontWeight.w400,
      //   ),
      // ),
      // dataTableTheme: const DataTableThemeData(),
      listTileTheme: ListTileThemeData(
        tileColor: CustomColor.lightGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      dividerTheme: const DividerThemeData(space: 1.0),
      dividerColor: CustomColor.grey,
      // popupMenuTheme: PopupMenuThemeData(
      //   textStyle: TextStyle(
      //     color: CustomColor.black,
      //   ),
      //   color: CustomColor.lightGreen,
      // ),
      // elevatedButtonTheme: ElevatedButtonThemeData(
      //   style: ElevatedButton.styleFrom(
      //     primary: CustomColor.darkGreen,
      //     textStyle: TextStyle(
      //       color: CustomColor.black,
      //     ),
      //   ),
      // ),
      // textButtonTheme: TextButtonThemeData(
      //   style: TextButton.styleFrom(
      //     textStyle: TextStyle(
      //       color: CustomColor.black,
      //     ),
      //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      //   ),
      // ),
      // floatingActionButtonTheme: FloatingActionButtonThemeData(
      //   shape: const StadiumBorder(),
      //   foregroundColor: CustomColor.black,
      //   backgroundColor: CustomColor.darkGreen,
      // ),
    );
  }
}

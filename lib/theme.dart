import 'package:flutter/material.dart';

class PinterestTheme {
  static ThemeData defaultTheme = ThemeData(
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: Colors.black),
      actionsIconTheme: const IconThemeData(color: Colors.black),
      color: Colors.grey[200],
      textTheme: const TextTheme(
        headline1: TextStyle(
          color: Colors.black,
        ),
        headline6: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
    ),
    colorScheme: ColorScheme.dark(),
    iconTheme: const IconThemeData(color: Colors.black),
    textTheme: const TextTheme(),
    accentColor: Colors.red,
    buttonColor: Colors.red,
    scaffoldBackgroundColor: Colors.grey[200],
  );
}

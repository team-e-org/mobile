import 'package:flutter/material.dart';

final ThemeData pinterestThemeData = ThemeData(
  appBarTheme: AppBarTheme(
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
  textTheme: const TextTheme(),
  accentColor: Colors.red,
  buttonColor: Colors.red,
  scaffoldBackgroundColor: Colors.grey[200],
);

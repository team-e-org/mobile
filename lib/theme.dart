import 'package:flutter/material.dart';

class PinterestTheme {
  static ThemeData defaultTheme = ThemeData(
      //  brightness:
      //  visualDensity:
      //  primarySwatch:
      primaryColor: ColorPalettes.defaultPalette.primary,
      //  primaryColorBrightness:
      primaryColorLight: ColorPalettes.defaultPalette.secondary,
      primaryColorDark: ColorPalettes.defaultPalette.third,
      accentColor: ColorPalettes.defaultPalette.primary,
      //  accentColorBrightness:
      //  canvasColor:
      scaffoldBackgroundColor: ColorPalettes.defaultPalette.background,
      //  bottomAppBarColor:
      //  cardColor:
      //  dividerColor:
      //  focusColor:
      //  hoverColor:
      //  highlightColor:
      //  splashColor:
      //  splashFactory:
      //  selectedRowColor:
      //  unselectedWidgetColor:
      //  disabledColor:
      buttonColor: ColorPalettes.defaultPalette.background,
      buttonTheme: ButtonThemeData(
        buttonColor: ColorPalettes.defaultPalette.background,
      ),
      //  toggleButtonsTheme:
      //  secondaryHeaderColor:
      //  textSelectionColor:
      //  cursorColor:
      //  textSelectionHandleColor:
      backgroundColor: ColorPalettes.defaultPalette.background,
      //  dialogBackgroundColor:
      //  indicatorColor:
      //  hintColor:
      //  errorColor:
      //  toggleableActiveColor:
      //  fontFamily:
      textTheme: TextTheme(
        button: TextStyle(
          color: ColorPalettes.defaultPalette.primaryText,
        ),
      ),
      primaryTextTheme: TextTheme(
        button: TextStyle(
          color: ColorPalettes.defaultPalette.thirdText,
        ),
        headline6: TextStyle(),
      ),
      //  accentTextTheme:
      //  inputDecorationTheme:
      //  iconTheme:
      //  primaryIconTheme:
      //  accentIconTheme:
      //  sliderTheme:
      //  tabBarTheme:
      //  tooltipTheme:
      //  cardTheme:
      //  chipTheme:
      //  platform:
      //  materialTapTargetSize:
      //  applyElevationOverlayColor:
      //  pageTransitionsTheme:
      appBarTheme: AppBarTheme(
        // brightness:
        color: ColorPalettes.defaultPalette.background,
        // elevation:
        iconTheme: iconTheme,
        actionsIconTheme: iconTheme,
        textTheme: textTheme,
      ),
      //  bottomAppBarTheme:
      //  colorScheme:
      //  dialogTheme:
      //  floatingActionButtonTheme:
      //  navigationRailTheme:
      //  typography:
      //  cupertinoOverrideTheme:
      //  snackBarTheme:
      //  bottomSheetTheme:
      //  popupMenuTheme:
      //  bannerTheme:
      //  dividerTheme:
      //  buttonBarTheme:
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorPalettes.defaultPalette.background,
      )
      //  fixTextFieldOutlineLabel:
      );

  static Color backgroundColor = Colors.grey[50];

  static TextTheme textTheme = TextTheme(
    headline1: TextStyle(color: ColorPalettes.defaultPalette.primaryText),
    headline2: TextStyle(color: ColorPalettes.defaultPalette.primaryText),
    headline3: TextStyle(color: ColorPalettes.defaultPalette.primaryText),
    headline4: TextStyle(color: ColorPalettes.defaultPalette.primaryText),
    headline5: TextStyle(color: ColorPalettes.defaultPalette.primaryText),
    headline6: TextStyle(
        color: ColorPalettes.defaultPalette.primaryText, fontSize: 18),
    subtitle1: TextStyle(color: ColorPalettes.defaultPalette.primaryText),
    subtitle2: TextStyle(color: ColorPalettes.defaultPalette.primaryText),
    bodyText1: TextStyle(
        color: ColorPalettes.defaultPalette.primaryText, fontSize: 18),
    bodyText2: TextStyle(
        color: ColorPalettes.defaultPalette.primaryText, fontSize: 14),
    caption: TextStyle(color: ColorPalettes.defaultPalette.primaryText),
    button: TextStyle(
      color: ColorPalettes.defaultPalette.icon,
      backgroundColor: ColorPalettes.defaultPalette.forth,
    ),
    overline: TextStyle(color: ColorPalettes.defaultPalette.primary),
  );

  static IconThemeData iconTheme = IconThemeData(
    color: ColorPalettes.defaultPalette.primaryText,
    // opacity:
    // size:
  );
}

class ColorPalettes {
  static ColorPalette defaultPalette = ColorPalette(
    primary: Color(0xfff33535),
    secondary: Color(0xffd8e9f0),
    third: Color(0xff33425b),
    forth: Color(0xff29252c),
    primaryText: Color(0xff212121),
    secondaryText: Color(0xff757575),
    thirdText: Color(0xffffffff),
    icon: Color(0xffffffff),
    divider: Color(0xffbdbdbd),
    background: Color(0xffffffff),
  );
}

class ColorPalette {
  const ColorPalette({
    this.primary,
    this.secondary,
    this.third,
    this.forth,
    this.primaryText,
    this.secondaryText,
    this.thirdText,
    this.icon,
    this.divider,
    this.background,
  });
  final Color primary;
  final Color secondary;
  final Color third;
  final Color forth;
  final Color primaryText;
  final Color secondaryText;
  final Color thirdText;
  final Color icon;
  final Color divider;
  final Color background;
}

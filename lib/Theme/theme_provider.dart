import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData lightTheme = ThemeData(
      primaryColor: Colors.white,
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.light(
        primary: Colors.teal,
        surface: Colors.teal,
        background: Colors.teal,
        onBackground: Colors.white,
        onPrimary: Colors.white,
      )
      // Add any other light mode specific theme configurations here
      );

  ThemeData darkTheme = ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: Color.fromARGB(255, 59, 53, 53),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        color: Colors.teal, // Set the text color to green
      ),
      bodyText2: TextStyle(
        color: Colors.teal, // Set the text color to green
      ),
      // Add any other text styles you want to customize
    ),
    // Add any other dark mode specific theme configurations here
  );

  bool isDarkMode = false;

  ThemeData get themeData => isDarkMode ? darkTheme : lightTheme;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}

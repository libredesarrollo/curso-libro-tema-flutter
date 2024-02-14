import 'package:flutter/material.dart';

class ThemeSwitch with ChangeNotifier {
  bool _darkTheme;

  late ThemeData _currentTheme;

  bool get darkTheme => _darkTheme;
  ThemeData get currentTheme => _currentTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    _changeTheme();
  }

  ThemeSwitch(this._darkTheme) {
    _changeTheme();
  }
  _changeTheme() {
    if (_darkTheme) {
      _currentTheme = ThemeData.light().copyWith(
        primaryColor: Colors.purpleAccent,
        textTheme: const TextTheme(
            displayLarge: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.black),
            displayMedium: TextStyle(color: Colors.black)),
      );
    } else {
      _currentTheme = ThemeData.dark().copyWith(
        primaryColor: Colors.deepPurple,
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          displayMedium: TextStyle(color: Colors.black),
        ),
      );
    }

    notifyListeners();
  }
}

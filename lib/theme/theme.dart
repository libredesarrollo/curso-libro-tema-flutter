import 'package:flutter/material.dart';

/// ThemeSwitch gestiona el tema actual de la aplicación.
/// Soporta tres modos: claro (light), oscuro (dark) y personalizado (custom).
class ThemeSwitch with ChangeNotifier {
  bool _darkTheme;
  ThemeMode _themeMode; // light, dark, custom

  late ThemeData _currentTheme;

  bool get darkTheme => _darkTheme;
  ThemeData get currentTheme => _currentTheme;
  ThemeMode get themeMode => _themeMode;

  /// Setter para el modo booleano claro/oscuro (compatibilidad con el Switch del Drawer)
  set darkTheme(bool value) {
    _darkTheme = value;
    _themeMode = value ? ThemeMode.light : ThemeMode.dark;
    _changeTheme();
  }

  /// Setter para cambiar entre los tres modos disponibles
  set themeMode(ThemeMode mode) {
    _themeMode = mode;
    _darkTheme = mode == ThemeMode.light;
    _changeTheme();
  }

  ThemeSwitch(this._darkTheme)
    : _themeMode = _darkTheme ? ThemeMode.light : ThemeMode.dark {
    _changeTheme();
  }

  void _changeTheme() {
    switch (_themeMode) {
      case ThemeMode.light:
        _currentTheme = ThemeData.light().copyWith(
          primaryColor: Colors.purpleAccent,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.purpleAccent,
            brightness: Brightness.light,
          ),
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            bodyMedium: TextStyle(color: Colors.black87),
            displayMedium: TextStyle(color: Colors.black87),
          ),
        );
        break;
      case ThemeMode.dark:
        _currentTheme = ThemeData.dark().copyWith(
          primaryColor: Colors.deepPurple,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          ),
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            bodyMedium: TextStyle(color: Colors.white70),
            displayMedium: TextStyle(color: Colors.white70),
          ),
        );
        break;
      case ThemeMode.system:
        // Tema personalizado "Purple"
        _currentTheme = ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          ),
          primaryColor: Colors.purple,
          scaffoldBackgroundColor: const Color(0xFF1E1040),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF2D1B69),
            foregroundColor: Colors.white,
          ),
          cardTheme: const CardThemeData(color: Color(0xFF2D1B69)),
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            bodyMedium: TextStyle(color: Colors.white70),
            displayMedium: TextStyle(color: Colors.purpleAccent),
          ),
        );
        break;
    }

    notifyListeners();
  }
}

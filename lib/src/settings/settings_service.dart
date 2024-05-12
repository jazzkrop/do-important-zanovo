import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SeedColors {
  static Color greenColor = const Color.fromARGB(255, 111, 243, 157); //green
  static Color pinkColor = const Color.fromARGB(230, 255, 203, 221); //pink
}

class StoredSettings {
  static String themeMode = "themeMode";
  static String seedColor = "seedColor";
  static String hapticFeedback = "hapticFeedback";
}

/// A service that stores and retrieves user settings.
///
/// By default, this class does not persist user settings. If you'd like to
/// persist the user settings locally, use the shared_preferences package. If
/// you'd like to store settings on a web server, use the http package.
class SettingsService {
  /// Loads the User's preferred ThemeMode from local or remote storage.
  Future<ThemeMode> themeMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var themeStr = prefs.getString(StoredSettings.themeMode);
    if (themeStr == "ThemeMode.dark") {
      return ThemeMode.dark;
    } else if (themeStr == "ThemeMode.light") {
      return ThemeMode.light;
    }
    return ThemeMode.system;
  }

  Future<Color> seedColor() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var seedStr = prefs.getString(StoredSettings.seedColor);
    if (seedStr == "Color(0xe6ffcbdd)") {
      return SeedColors.pinkColor;
    } else if (seedStr == "Color(0xff6ff39d)") {
      return SeedColors.greenColor;
    }
    return SeedColors.pinkColor; //pink
  }

  Future<bool> hapticFeedback() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var seedStr = prefs.getString(StoredSettings.hapticFeedback);
    if (seedStr == "true") {
      return true; //pink
    } else if (seedStr == "false") {
      return false; //green
    }
    return true; //pink
  }

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<void> updateThemeMode(ThemeMode theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(StoredSettings.themeMode, theme.toString());

    // Use the shared_preferences package to persist settings locally or the
    // http package to persist settings over the network.
  }

  Future<void> updateSeedColor(Color seedColor) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(StoredSettings.seedColor, seedColor.toString());

    print(seedColor.toString());
  }

  Future<void> updateHapticFeedback(bool hapticFeedback) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(
        StoredSettings.hapticFeedback, hapticFeedback.toString());
  }
}

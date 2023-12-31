import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service that stores and retrieves user settings.
///
/// By default, this class does not persist user settings. If you'd like to
/// persist the user settings locally, use the shared_preferences package. If
/// you'd like to store settings on a web server, use the http package.
class SettingsService {
  /// Loads the User's preferred ThemeMode from local or remote storage.
  Future<ThemeMode> themeMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var themeStr = prefs.getString('themeMode');
    if (themeStr == "") {
      return ThemeMode.system;
    }
    // TODO: store from shared prefs
    return ThemeMode.system;
  }

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<void> updateThemeMode(ThemeMode theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // await prefs.setString('themeMode', theme.toString());
    // Use the shared_preferences package to persist settings locally or the
    // http package to persist settings over the network.
  }
}

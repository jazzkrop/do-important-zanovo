import 'package:flutter/material.dart';

import 'settings_service.dart';

/// A class that many Widgets can interact with to read user settings, update
/// user settings, or listen to user settings changes.
///
/// Controllers glue Data Services to Flutter Widgets. The SettingsController
/// uses the SettingsService to store and retrieve user settings.
class SettingsController with ChangeNotifier {
  SettingsController(this._settingsService);

  // Make SettingsService a private variable so it is not used directly.
  final SettingsService _settingsService;

  late ThemeMode _themeMode;
  late Color _seedColor;
  late bool _hapticFeedback;

  ThemeMode get themeMode => _themeMode;
  Color get seedColor => _seedColor;
  bool get hapticFeedback => _hapticFeedback;

  /// Load the user's settings from the SettingsService. It may load from a
  /// local database or the internet. The controller only knows it can load the
  /// settings from the service.
  Future<void> loadSettings() async {
    _themeMode = await _settingsService.themeMode();
    _seedColor = await _settingsService.seedColor();
    _hapticFeedback = await _settingsService.hapticFeedback();
    // Important! Inform listeners a change has occurred.
    notifyListeners();
  }

  /// Update and persist the ThemeMode based on the user's selection.
  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    // Do not perform any work if new and old ThemeMode are identical
    if (newThemeMode == _themeMode) return;

    // Otherwise, store the new ThemeMode in memory
    _themeMode = newThemeMode;

    // Important! Inform listeners a change has occurred.
    notifyListeners();

    await _settingsService.updateThemeMode(newThemeMode);
  }

  Future<void> updateSeedColor(Color? newSeedColor) async {
    if (newSeedColor == null) return;

    if (newSeedColor == _seedColor) return;

    _seedColor = newSeedColor;

    notifyListeners();

    await _settingsService.updateSeedColor(newSeedColor);
  }

  Future<void> updateHapticFeedback(bool? newHapticFeedback) async {
    if (newHapticFeedback == null) return;

    if (newHapticFeedback == _hapticFeedback) return;

    _hapticFeedback = newHapticFeedback;

    notifyListeners();

    await _settingsService.updateHapticFeedback(newHapticFeedback);
  }
}

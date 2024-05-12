import 'package:do_important_zanovo/src/settings/settings_controller.dart';
import 'package:do_important_zanovo/src/settings/settings_service.dart';
import 'package:flutter/material.dart';

class SettingsModel extends ChangeNotifier {
  SettingsController settingsController = SettingsController(SettingsService());
}

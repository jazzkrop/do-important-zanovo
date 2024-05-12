// ignore_for_file: prefer_const_constructors

import 'package:do_important_zanovo/src/settings/settings_service.dart';
import 'package:flutter/material.dart';

import 'settings_controller.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.controller});

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Налаштування',
          style: TextStyle(fontSize: 32),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        // Glue the SettingsController to the theme selection DropdownButton.
        //

        // тема:
        // системна, темна, світла
        // When a user selects a theme from the dropdown list, the
        // SettingsController is updated, which rebuilds the MaterialApp.
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SegmentedButton(
                  segments: const <ButtonSegment<ThemeMode>>[
                    ButtonSegment<ThemeMode>(
                        value: ThemeMode.system,
                        label: Text('Система'),
                        icon: Icon(Icons.phone_iphone_outlined)),
                    ButtonSegment<ThemeMode>(
                        value: ThemeMode.dark,
                        label: Text('Темна'),
                        icon: Icon(Icons.nightlight_outlined)),
                    ButtonSegment<ThemeMode>(
                        value: ThemeMode.light,
                        label: Text('Світла'),
                        icon: Icon(Icons.wb_sunny_outlined)),
                  ],
                  selected: <ThemeMode>{controller.themeMode},
                  onSelectionChanged: (Set<ThemeMode> newSelection) {
                    controller.updateThemeMode(newSelection.first);
                  },
                ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SegmentedButton(
                  segments: <ButtonSegment<Color>>[
                    ButtonSegment<Color>(
                      value: SeedColors.greenColor,
                      label: Text('Зелений'),
                      icon: Icon(Icons.nature_outlined),
                    ),
                    ButtonSegment<Color>(
                        value: SeedColors.pinkColor,
                        label: Text('Рожевий'),
                        icon: Icon(Icons.auto_awesome_sharp)),
                  ],
                  selected: <Color>{controller.seedColor},
                  onSelectionChanged: (Set<Color> newSelection) {
                    controller.updateSeedColor(newSelection.first);
                  },
                ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SegmentedButton(
                  segments: const <ButtonSegment<bool>>[
                    ButtonSegment<bool>(
                      value: true,
                      label: Text('Вібрація'),
                      icon: Icon(Icons.vibration),
                    ),
                    ButtonSegment<bool>(
                        value: false,
                        label: Text('Без'),
                        icon: Icon(Icons.do_disturb_alt_outlined)),
                  ],
                  selected: <bool>{controller.hapticFeedback},
                  onSelectionChanged: (Set<bool> newSelection) {
                    controller.updateHapticFeedback(newSelection.first);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

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
        title: const Text('Налаштування'),
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
            SegmentedButton(
              segments: const <ButtonSegment<ThemeMode>>[
                ButtonSegment<ThemeMode>(
                    value: ThemeMode.system,
                    label: Text('Системна'),
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
            DropdownButton<ThemeMode>(
              // Read the selected themeMode from the controller
              value: controller.themeMode,
              // Call the updateThemeMode method any time the user selects a theme.
              onChanged: controller.updateThemeMode,
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('Повторювати системну'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text('Світла'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text('Темна'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sample_feature/sample_item_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The ListenableBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          restorationScopeId: 'app',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: GoogleFonts.ysabeauInfant().fontFamily,
            textTheme: GoogleFonts.ysabeauInfantTextTheme(),
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: settingsController.seedColor,
            ),
          ),
          darkTheme: ThemeData(
            fontFamily: GoogleFonts.ysabeauInfant().fontFamily,
            textTheme: GoogleFonts.ysabeauInfantTextTheme(
                ThemeData(brightness: Brightness.dark).textTheme),
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: settingsController.seedColor,
              brightness: Brightness.dark,
            ),
          ),
          themeMode: settingsController.themeMode,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case SampleItemListView.routeName:
                  default:
                    return SampleItemListView();
                }
              },
            );
          },
        );
      },
    );
  }
}

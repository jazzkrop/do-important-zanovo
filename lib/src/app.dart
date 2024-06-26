import 'package:do_important_zanovo/src/importance_feature/importance_screen.dart';
import 'package:do_important_zanovo/src/settings/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'task_feature/task_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  MyApp({super.key});

  late SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    settingsController =
        Provider.of<SettingsModel>(context, listen: false).settingsController;
    // The ListenableBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        var colorScheme =
            ColorScheme.fromSeed(seedColor: settingsController.seedColor);

        ThemeData themeData = ThemeData(
          bottomSheetTheme: const BottomSheetThemeData(showDragHandle: true),
          fontFamily: GoogleFonts.ysabeauInfant().fontFamily,
          textTheme: GoogleFonts.ysabeauInfantTextTheme()
              .copyWith(titleMedium: const TextStyle(fontSize: 17)),
          useMaterial3: true,
          colorScheme: colorScheme,
          inputDecorationTheme: const InputDecorationTheme(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          ),
        );

        ThemeData themeDataDark = ThemeData(
          bottomSheetTheme: const BottomSheetThemeData(showDragHandle: true),
          fontFamily: GoogleFonts.ysabeauInfant().fontFamily,
          textTheme: GoogleFonts.ysabeauInfantTextTheme(
                  ThemeData(brightness: Brightness.dark).textTheme)
              .copyWith(titleMedium: const TextStyle(fontSize: 17)),
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: settingsController.seedColor,
            brightness: Brightness.dark,
          ),
          inputDecorationTheme: const InputDecorationTheme(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          ),
        );

        return MaterialApp(
          restorationScopeId: 'app',
          debugShowCheckedModeBanner: false,
          theme: themeData,
          darkTheme: themeDataDark,
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
                  case ImportanceScreen.routeName:
                    return ImportanceScreen();
                  case TaskListView.routeName:
                  default:
                    return TaskListView();
                }
              },
            );
          },
        );
      },
    );
  }
}

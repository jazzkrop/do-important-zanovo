import 'package:do_important_zanovo/src/settings/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ImportanceForm extends StatelessWidget {
  ImportanceForm(
      {super.key,
      required this.importanceType,
      required this.value,
      required this.onTap});

  final int importanceType;
  final bool value;
  final Function onTap;

  double circleDiametr = 20;

  void onImportanceTap(context) {
    if (Provider.of<SettingsModel>(context, listen: false)
        .settingsController
        .hapticFeedback) {
      HapticFeedback.lightImpact();
    }
    onTap();
  }

  @override
  Widget build(BuildContext context) {
    switch (importanceType) {
      case 1:
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: InkWell(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(24)),
            onTap: () {
              onImportanceTap(context);
            },
            child: AspectRatio(
              aspectRatio: 1,
              child: Ink(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.only(topLeft: Radius.circular(24)),
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 120),
                    curve: Curves.easeIn,
                    height: value ? circleDiametr : 0,
                    width: value ? circleDiametr : 0,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      case 2:
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: InkWell(
            borderRadius:
                const BorderRadius.only(topRight: Radius.circular(24)),
            onTap: () {
              onImportanceTap(context);
            },
            child: AspectRatio(
              aspectRatio: 1,
              child: Ink(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.only(topRight: Radius.circular(24)),
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 120),
                    curve: Curves.easeIn,
                    height: value ? circleDiametr : 0,
                    width: value ? circleDiametr : 0,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      case 3:
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: InkWell(
            borderRadius:
                const BorderRadius.only(bottomLeft: Radius.circular(24)),
            onTap: () {
              onImportanceTap(context);
            },
            child: AspectRatio(
              aspectRatio: 1,
              child: Ink(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.only(bottomLeft: Radius.circular(24)),
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                child: Center(
                    child: AnimatedContainer(
                  duration: const Duration(milliseconds: 120),
                  curve: Curves.easeIn,
                  height: value ? circleDiametr : 0,
                  width: value ? circleDiametr : 0,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )),
              ),
            ),
          ),
        );
      case 4:
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: InkWell(
            borderRadius:
                const BorderRadius.only(bottomRight: Radius.circular(24)),
            onTap: () {
              onImportanceTap(context);
            },
            child: AspectRatio(
              aspectRatio: 1,
              child: Ink(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.only(bottomRight: Radius.circular(24)),
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                child: Center(
                    child: AnimatedContainer(
                  duration: const Duration(milliseconds: 120),
                  curve: Curves.easeIn,
                  height: value ? circleDiametr : 0,
                  width: value ? circleDiametr : 0,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )),
              ),
            ),
          ),
        );
      default:
        return Text('error');
    }
  }
}

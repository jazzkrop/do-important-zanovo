import 'dart:ui';

import 'package:do_important_zanovo/src/core/models/task_model.dart';
import 'package:do_important_zanovo/src/settings/settings_model.dart';
import 'package:do_important_zanovo/src/task_feature/task_controller.dart';
import 'package:do_important_zanovo/src/task_feature/widgets/importance_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

createTask(context) {
  double formHeight = screenSize.height * 0.6;

  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SizedBox(
          height: formHeight,
          child: const TaskForm(),
        );
      });

// 411 pixel 6a
// 392 telefon vlada xiaomi
  //375 xperia 5 ii
}

editTask(context, Task initialTask) {
  double formHeight = screenSize.height * 0.6;
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SizedBox(
          height: formHeight,
          child: TaskForm(
            initialTask: initialTask,
          ),
        );
      });
}

FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
Size screenSize = view.physicalSize / view.devicePixelRatio;

class TaskForm extends StatefulWidget {
  const TaskForm({super.key, this.initialTask});
  final Task? initialTask;

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  TextEditingController titleController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  var titleFocusNode = FocusNode();
  var reasonFocusNode = FocusNode();
  bool firtTitleAlreadyFocused = false;

  int importanceState = 0;

  void deleteTask() async {
    if (Provider.of<SettingsModel>(context, listen: false)
        .settingsController
        .hapticFeedback) {
      HapticFeedback.lightImpact();
    }
    TaskController().deleteTask(widget.initialTask!.id);
    Navigator.pop(context);
  }

  void onSuccesTap() {
    if (Provider.of<SettingsModel>(context, listen: false)
        .settingsController
        .hapticFeedback) {
      HapticFeedback.lightImpact();
    }

    TaskController taskController = TaskController();

    if (widget.initialTask == null) {
      if (importanceState == 0) {
        importanceState = 4;
      }
      taskController.createTask(
        title: titleController.text,
        reason: reasonController.text,
        importance: importanceState,
      );
    } else {
      taskController.editTask(
          id: widget.initialTask!.id,
          title: titleController.text,
          reason: reasonController.text,
          importance: importanceState);
    }
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialTask != null) {
      titleController.text = widget.initialTask!.title;
      reasonController.text = widget.initialTask!.reason!;
      firtTitleAlreadyFocused = true;
      importanceState = widget.initialTask!.importance!;
    } else {
      titleController.text = "";
      reasonController.text = "";
      importanceState = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (firtTitleAlreadyFocused == false) {
      titleFocusNode.requestFocus();
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                maxLength: 60,
                scrollPadding: EdgeInsets.zero,
                decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    labelText: "що",
                    contentPadding: EdgeInsets.zero,
                    hintText: 'шо будеш робити?'),
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                ),
                controller: titleController,
                focusNode: titleFocusNode,
                onEditingComplete: () {
                  if (reasonController.text == "") {
                    firtTitleAlreadyFocused = true;
                    reasonFocusNode.requestFocus();
                  } else {
                    titleFocusNode.unfocus(
                        disposition: UnfocusDisposition.scope);
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                maxLength: 30,
                decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    labelText: "чому",
                    contentPadding: EdgeInsets.zero,
                    hintText: 'чому ти це робиш?'),
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                ),
                focusNode: reasonFocusNode,
                controller: reasonController,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 48),
          child: Column(
            children: [
              Row(
                children: [
                  const RotatedBox(
                    quarterTurns: 3,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 4.0, right: 26, top: 0),
                      child: SizedBox(
                          height: 14,
                          child: Text(
                            'важливо',
                            style: TextStyle(height: 0.4, fontSize: 14),
                          )),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const Text("терміново"),
                        const SizedBox(height: 4),
                        ImportanceForm(
                            importanceType: 1,
                            value: importanceState == 1,
                            onTap: () {
                              setState(() {
                                importanceState = 1;
                              });
                            }),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const Text("почекає"),
                        const SizedBox(height: 4),
                        ImportanceForm(
                            importanceType: 2,
                            value: importanceState == 2,
                            onTap: () {
                              setState(() {
                                importanceState = 2;
                              });
                            }),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 124,
                    height: 120,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (widget.initialTask != null)
                          SizedBox(
                            height: 80,
                            width: 80,
                            child: FilledButton.tonal(
                              style: FilledButton.styleFrom(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(24),
                                    bottomLeft: Radius.circular(24),
                                  ),
                                ),
                              ),
                              onPressed: deleteTask,
                              child: const SizedBox(
                                height: 24,
                                child: Text(
                                  "е..",
                                  style: TextStyle(fontSize: 24, height: 0.4),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  const RotatedBox(
                    quarterTurns: 3,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 4.0),
                      child: SizedBox(
                        height: 14,
                        child: Text(
                          'не важливо',
                          style: TextStyle(fontSize: 14, height: 0.4),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        ImportanceForm(
                            importanceType: 3,
                            value: importanceState == 3,
                            onTap: () {
                              setState(() {
                                importanceState = 3;
                              });
                            }),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ImportanceForm(
                      importanceType: 4,
                      onTap: () {
                        setState(() {
                          importanceState = 4;
                        });
                      },
                      value: importanceState == 4,
                    ),
                  ),
                  SizedBox(
                    width: 124,
                    height: 100,
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 80,
                          width: 80,
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(24),
                                  bottomLeft: Radius.circular(24),
                                ),
                              ),
                            ),
                            onPressed: onSuccesTap,
                            child: const SizedBox(
                              height: 24,
                              child: Text(
                                "є.",
                                style: TextStyle(fontSize: 24, height: 0.4),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

import 'dart:js_interop';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_important_zanovo/src/core/models/task_model.dart';
import 'package:do_important_zanovo/src/core/services/db_constants.dart';
import 'package:do_important_zanovo/src/task_feature/task_list_view.dart';
import 'package:do_important_zanovo/src/task_feature/task_simple_view.dart';
import 'package:do_important_zanovo/src/widgets/screen_wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ImportanceScreen extends StatefulWidget {
  const ImportanceScreen({super.key});

  static const routeName = '/importanceScreen';

  @override
  State<ImportanceScreen> createState() => _ImportanceScreenState();
}

class _ImportanceScreenState extends State<ImportanceScreen> {
  List<Task> tasksList = [];

  FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
  late Size screenSize = view.physicalSize / view.devicePixelRatio;
  double horizontalPadding = 20.0;
  double textHeight = 16;
  double textGapHeight = 4;

  late double squareWidth =
      (screenSize.width - horizontalPadding * 2 - textHeight) / 2 -
          textGapHeight;

  @override
  void initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseFirestore.instance
          .collection(DatabasePaths.users)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection(DatabasePaths.tasks)
          .orderBy(Task.createdAtStr, descending: true)
          .where(Task.doneAtStr, isEqualTo: 0)
          .get(const GetOptions(source: Source.cache))
          .then((value) {
        for (var item in value.docs) {
          tasksList.add(Task.fromFirestore(item, SnapshotOptions()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Expanded(
            child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: horizontalPadding, right: horizontalPadding),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RotatedBox(
                        quarterTurns: 3,
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: textGapHeight, right: 26, top: 0),
                          child: SizedBox(
                              height: textHeight,
                              child: const Text(
                                'важливо',
                                style: TextStyle(height: 0.4, fontSize: 16),
                              )),
                        ),
                      ),
                      Column(
                        children: [
                          const Text(
                            "терміново",
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 2),
                          Container(
                            width: squareWidth,
                            height: squareWidth,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(24)),
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            "почекає",
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 2),
                          Container(
                            width: squareWidth,
                            height: squareWidth,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(24)),
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      RotatedBox(
                        quarterTurns: 3,
                        child: Padding(
                          padding:
                              EdgeInsets.only(bottom: textGapHeight, top: 0),
                          child: SizedBox(
                              height: textHeight,
                              child: const Text(
                                'не важливо',
                                style: TextStyle(height: 0.4, fontSize: 16),
                              )),
                        ),
                      ),
                      Container(
                        width: squareWidth,
                        height: squareWidth,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(24)),
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                        ),
                      ),
                      Container(
                        width: squareWidth,
                        height: squareWidth,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(24)),
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    restorationId: 'TaskListView',
                    itemCount: tasksList.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      final item = tasksList[index];
                      double taskSmallWidth = 260;
                      double taskSmallHeight = 150;

                      return Align(
                        child: Draggable(
                          key: Key(item.id),
                          dragAnchorStrategy: (draggable, context, position) =>
                              Offset(taskSmallWidth / 2, taskSmallHeight / 2),
                          feedback: SizedBox(
                            width: taskSmallWidth,
                            child: TaskSimpleView(
                              importanceMode: true,
                              task: item,
                              key: Key(item.id),
                            ),
                          ),
                          childWhenDragging: TaskSimpleView(
                            transperent: true,
                            importanceMode: true,
                            task: item,
                            key: Key(item.id),
                          ),
                          child: TaskSimpleView(
                            importanceMode: true,
                            task: item,
                            key: Key(item.id),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}

import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_important_zanovo/src/core/models/task_model.dart';
import 'package:do_important_zanovo/src/core/services/db_constants.dart';
import 'package:do_important_zanovo/src/importance_feature/widgets/drag_task_list.dart';
import 'package:do_important_zanovo/src/importance_feature/widgets/task_drag_feedback.dart';
import 'package:do_important_zanovo/src/task_feature/task_controller.dart';
import 'package:do_important_zanovo/src/widgets/screen_wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
Size screenSize = view.physicalSize / view.devicePixelRatio;
double horizontalPadding = 20.0;
double textHeight = 16;
double textGapHeight = 4;

class ImportanceScreen extends StatefulWidget {
  const ImportanceScreen({super.key});

  static const routeName = '/importanceScreen';

  @override
  State<ImportanceScreen> createState() => _ImportanceScreenState();
}

class _ImportanceScreenState extends State<ImportanceScreen> {
  List<Task> tasksList = [];
  List<Task> tasksImp1 = [];
  List<Task> tasksImp2 = [];
  List<Task> tasksImp3 = [];
  List<Task> tasksImp4 = [];

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
          .orderBy(Task.importanceStr, descending: true)
          .where(Task.doneAtStr, isEqualTo: 0)
          .get(const GetOptions(source: Source.cache))
          .then((value) {
        for (var item in value.docs) {
          tasksList.add(Task.fromFirestore(item, SnapshotOptions()));
          setState(() {});
        }
        tasksList.sort((a, b) => a.importance!.compareTo(b.importance!));
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
                          renderImportantSquareDrag(
                            parrentType: taskPlaces.importance1,
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
                          renderImportantSquareDrag(
                            parrentType: taskPlaces.importance2,
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
                      renderImportantSquareDrag(
                        parrentType: taskPlaces.importance3,
                      ),
                      renderImportantSquareDrag(
                        parrentType: taskPlaces.importance4,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    restorationId: 'TaskListView',
                    itemCount: tasksList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = tasksList[index];

                      return DraggableTaskList(item: item);
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

  DragTarget<DragTaskData> renderImportantSquareDrag(
      {required taskPlaces parrentType}) {
    late List<Task> squareTasks;

    TaskController taskController = TaskController();

    switch (parrentType) {
      case taskPlaces.importance1:
        squareTasks = tasksImp1;
        break;
      case taskPlaces.importance2:
        squareTasks = tasksImp2;
        break;
      case taskPlaces.importance3:
        squareTasks = tasksImp3;
        break;
      case taskPlaces.importance4:
        squareTasks = tasksImp4;
        break;
      default:
        null;
    }

    return DragTarget(
      onAccept: (DragTaskData data) {
        setState(() {
          if (parrentType == data.from) {
            return;
          }
          switch (parrentType) {
            case taskPlaces.importance1:
              // update
              taskController.editTask(id: data.task.id, importance: 1);
              tasksImp1.insert(0, data.task);
              squareTasks = tasksImp1;
              break;
            case taskPlaces.importance2:
              taskController.editTask(id: data.task.id, importance: 2);
              tasksImp2.insert(0, data.task);
              squareTasks = tasksImp2;
              break;
            case taskPlaces.importance3:
              taskController.editTask(id: data.task.id, importance: 3);
              tasksImp3.insert(0, data.task);
              squareTasks = tasksImp3;
              break;
            case taskPlaces.importance4:
              taskController.editTask(id: data.task.id, importance: 4);
              tasksImp4.insert(0, data.task);
              squareTasks = tasksImp4;
              break;
            default:
              null;
          }

          switch (data.from) {
            case taskPlaces.taskList:
              tasksList.remove(data.task);
              break;
            case taskPlaces.importance1:
              tasksImp1.remove(data.task);
              break;
            case taskPlaces.importance2:
              tasksImp2.remove(data.task);
              break;
            case taskPlaces.importance3:
              tasksImp3.remove(data.task);
              break;
            case taskPlaces.importance4:
              tasksImp4.remove(data.task);
              break;
            default:
              null;
          }
        });
      },
      builder: (context, candidateData, rejectedData) {
        late var boxDecoration;
        switch (parrentType) {
          case taskPlaces.importance1:
            boxDecoration = BoxDecoration(
              borderRadius:
                  const BorderRadius.only(topLeft: Radius.circular(24)),
              color: Theme.of(context).colorScheme.onSecondary,
            );
            break;
          case taskPlaces.importance2:
            boxDecoration = BoxDecoration(
              borderRadius:
                  const BorderRadius.only(topRight: Radius.circular(24)),
              color: Theme.of(context).colorScheme.secondaryContainer,
            );
            break;
          case taskPlaces.importance3:
            boxDecoration = BoxDecoration(
              borderRadius:
                  const BorderRadius.only(bottomLeft: Radius.circular(24)),
              color: Theme.of(context).colorScheme.secondaryContainer,
            );
            break;
          case taskPlaces.importance4:
            boxDecoration = BoxDecoration(
              borderRadius:
                  const BorderRadius.only(bottomRight: Radius.circular(24)),
              color: Theme.of(context).colorScheme.onSecondary,
            );
            break;
          default:
            null;
        }

        return Container(
          clipBehavior: Clip.antiAlias,
          width: squareWidth,
          height: squareWidth,
          decoration: boxDecoration,
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4.0),
            child: ListView(children: [
              const SizedBox(height: 4),
              ...squareTasks.map((Task task) {
                var taskCard = Card(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 12.0, top: 8),
                    child: Text(
                      task.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                );
                return LongPressDraggable(
                  data: DragTaskData(task: task, from: parrentType),
                  dragAnchorStrategy: (draggable, context, position) =>
                      const Offset(200, 200),
                  childWhenDragging: Opacity(
                    opacity: 0,
                    child: taskCard,
                  ),
                  feedback: TaskDragFeedback(
                    item: task,
                  ),
                  child: taskCard,
                );
              }),
              const SizedBox(height: 4),
            ]),
          ),
        );
      },
    );
  }
}

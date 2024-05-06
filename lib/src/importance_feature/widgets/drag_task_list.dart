import 'package:do_important_zanovo/src/core/models/task_model.dart';
import 'package:do_important_zanovo/src/importance_feature/widgets/task_drag_feedback.dart';
import 'package:do_important_zanovo/src/task_feature/task_simple_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum taskPlaces {
  taskList,
  importance1,
  importance2,
  importance3,
  importance4,
}

class DragTaskData {
  final Task task;
  final taskPlaces from;

  DragTaskData({required this.task, required this.from});
}

class DraggableTaskList extends StatelessWidget {
  const DraggableTaskList({
    super.key,
    required this.item,
  });
  final Task item;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Draggable(
        onDragStarted: () {
          HapticFeedback.selectionClick();
        },
        data: DragTaskData(task: item, from: taskPlaces.taskList),
        key: Key(item.id),
        dragAnchorStrategy: (draggable, context, position) =>
            const Offset(200, 200),
        feedback: TaskDragFeedback(item: item),
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
  }
}

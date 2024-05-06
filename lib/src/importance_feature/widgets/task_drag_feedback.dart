import 'package:do_important_zanovo/src/core/models/task_model.dart';
import 'package:flutter/material.dart';

class TaskDragFeedback extends StatelessWidget {
  final Task item;

  const TaskDragFeedback({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: Key(item.id),
      height: 400,
      width: 400,
      child: Align(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 50),
          width: 200,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8.0, bottom: 12.0, top: 8),
              child: Text(
                item.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

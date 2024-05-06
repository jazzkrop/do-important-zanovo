import 'package:do_important_zanovo/src/core/models/task_model.dart';
import 'package:do_important_zanovo/src/task_feature/task_controller.dart';
import 'package:do_important_zanovo/src/task_feature/task_form.dart';
import 'package:flutter/material.dart';

class TaskSimpleView extends StatefulWidget {
  const TaskSimpleView(
      {super.key, required this.task, this.importanceMode, this.transperent});

  final Task task;
  final bool? importanceMode;
  final bool? transperent;
  static const double cardBorderRadius = 12.0;

  @override
  State<TaskSimpleView> createState() => _TaskSimpleViewState();
}

class _TaskSimpleViewState extends State<TaskSimpleView> {
  late bool isDone = widget.task.doneAt != 0;

  void onTaskCheckTap(bool? value) {
    setState(() {
      isDone = value ?? false;
      value!
          ? TaskController().markTaskDone(widget.task)
          : TaskController().markTaskUndone(widget.task);
    });
  }

  void onTaskCardTapAction() {
    if (widget.importanceMode != null) return;
    editTask(context, widget.task);
  }

  @override
  Widget build(BuildContext context) {
    var doneCheck = SizedBox(
      height: 28,
      width: 28,
      child: Transform.scale(
        scale: 1.5,
        child: Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            side: MaterialStateBorderSide.resolveWith(
              (states) => BorderSide(
                  width: 1.2, color: Theme.of(context).colorScheme.primary),
            ),
            value: isDone,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft:
                    Radius.circular(TaskSimpleView.cardBorderRadius / 2),
                topRight: Radius.circular(TaskSimpleView.cardBorderRadius / 2),
              ),
            ),
            onChanged: onTaskCheckTap),
      ),
    );

    Widget importance() {
      bool important =
          widget.task.importance! < 3 && widget.task.importance! > 0;
      bool urgent = widget.task.importance! % 2 != 0;

      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (important) ...[
            Container(
              height: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(TaskSimpleView.cardBorderRadius),
                  bottomLeft: Radius.circular(TaskSimpleView.cardBorderRadius),
                ),
                // color: Theme.of(context).colorScheme.tertiary,
                color: Theme.of(context).colorScheme.surfaceTint,
              ),
              padding: const EdgeInsets.only(left: 4, right: 4),
              child: SizedBox(
                height: 14,
                child: Text('важливо',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 0.4,
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onPrimary,
                    )),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
          ],
          if (urgent)
            Container(
              height: 24,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 4, right: 4),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(TaskSimpleView.cardBorderRadius),
                  topRight: Radius.circular(TaskSimpleView.cardBorderRadius),
                ),
                color: Theme.of(context).colorScheme.tertiaryContainer,
              ),
              child: SizedBox(
                height: 14,
                child: Text(
                  'терміново',
                  style: TextStyle(
                      height: 0.5,
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onTertiaryContainer),
                ),
              ),
            )
        ],
      );
    }

    var taskBody = Padding(
      padding: const EdgeInsets.only(top: 4, left: 12, right: 12, bottom: 6),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(widget.task.title,
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                    height: 1.05)),
            Text(widget.task.reason!,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Theme.of(context).colorScheme.onSurfaceVariant)),
          ]),
    );

    return Opacity(
      opacity: widget.transperent != null ? 0 : 1,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Card(
          margin: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(TaskSimpleView.cardBorderRadius),
            ),
          ),
          child: InkWell(
            borderRadius: const BorderRadius.all(
                Radius.circular(TaskSimpleView.cardBorderRadius)),
            onTap: onTaskCardTapAction,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      taskBody,
                      if (widget.importanceMode == null) importance(),
                    ],
                  ),
                ),
                if (widget.importanceMode == null) doneCheck,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

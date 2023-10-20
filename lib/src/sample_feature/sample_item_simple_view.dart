import 'package:do_important_zanovo/src/sample_feature/sample_item.dart';
import 'package:flutter/material.dart';

class SampleItemSimpleView extends StatefulWidget {
  const SampleItemSimpleView({super.key, required this.item});

  final SampleItem item;
  static const double cardBorderRadius = 12.0;

  @override
  State<SampleItemSimpleView> createState() => _SampleItemSimpleViewState();
}

class _SampleItemSimpleViewState extends State<SampleItemSimpleView> {
  late bool isDone = widget.item.doneAt != null;

  @override
  Widget build(BuildContext context) {
    var doneCheck = SizedBox(
      height: 27,
      width: 27,
      child: Transform.scale(
          scale: 1.4,
          child: Checkbox(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              side: MaterialStateBorderSide.resolveWith(
                (states) => BorderSide(
                    width: 1.2, color: Theme.of(context).colorScheme.primary),
              ),
              value: isDone,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                      SampleItemSimpleView.cardBorderRadius / 2),
                  topRight: Radius.circular(
                      SampleItemSimpleView.cardBorderRadius / 2),
                ),
              ),
              onChanged: (bool? value) {
                setState(() {
                  isDone = value ?? false;
                  // make doneAt true/ listen on list to collection to db
                });
              })),
    );

    Widget importance() {
      bool important = widget.item.importance < 3;
      bool urgent = widget.item.importance % 2 != 0;

      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (important) ...[
            Container(
              height: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight:
                      Radius.circular(SampleItemSimpleView.cardBorderRadius),
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
                  bottomLeft:
                      Radius.circular(SampleItemSimpleView.cardBorderRadius),
                  topRight:
                      Radius.circular(SampleItemSimpleView.cardBorderRadius),
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
            Text(widget.item.title,
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                    height: 1.05)),
            Text(widget.item.reason,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant)),
          ]),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          margin: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(SampleItemSimpleView.cardBorderRadius),
            ),
          ),
          child: InkWell(
            borderRadius: const BorderRadius.all(
                Radius.circular(SampleItemSimpleView.cardBorderRadius)),
            onTap: () {},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      taskBody,
                      importance(),
                    ],
                  ),
                ),
                doneCheck,
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        )
      ],
    );
  }
}

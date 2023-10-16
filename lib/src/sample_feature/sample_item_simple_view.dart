import 'package:do_important_zanovo/src/sample_feature/sample_item.dart';
import 'package:flutter/material.dart';

class SampleItemSimpleView extends StatefulWidget {
  const SampleItemSimpleView({super.key, required this.item});

  final SampleItem item;
  static const double cardBorderRadius = 16.0;

  @override
  State<SampleItemSimpleView> createState() => _SampleItemSimpleViewState();
}

class _SampleItemSimpleViewState extends State<SampleItemSimpleView> {
  late bool isDone = widget.item.doneAt != null;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(SampleItemSimpleView.cardBorderRadius))),
          //  shape: ShapeBorder.lerp(, b, t),
          child: InkWell(
            borderRadius: const BorderRadius.all(
                Radius.circular(SampleItemSimpleView.cardBorderRadius)),
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Transform.scale(
                    scale: 1.4,
                    child: Checkbox(
                        value: isDone,
                        onChanged: (bool? value) {
                          setState(() {
                            isDone = value ?? false;
                            // make doneAt true/ listen on list to collection to db
                          });
                        }),
                  ),
                  Column(
                    children: [
                      Text(widget.item.title,
                          style: const TextStyle(fontSize: 18, height: 1.05)),
                      Text(widget.item.reason),
                      if (widget.item.valuesIds != null)
                        ...widget.item.valuesIds!.map(
                          (e) => const Text("сім'я"),
                        )
                    ],
                  ),
                ],
              ),
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

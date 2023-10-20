import 'package:do_important_zanovo/src/sample_feature/sample_item_simple_view.dart';
import 'package:do_important_zanovo/src/sample_feature/value.dart';
import 'package:do_important_zanovo/src/sample_feature/widgets/modal_auth.dart';
import 'package:do_important_zanovo/src/settings/settings_view.dart';
import 'package:do_important_zanovo/src/widgets/screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

import 'sample_item.dart';

/// Displays a list of SampleItems.
class SampleItemListView extends StatefulWidget {
  SampleItemListView({super.key, this.controller});

  final controller;

  static const routeName = '/';

  List<SampleItem> items = [
    SampleItem(
      id: '1',
      createdAt: DateTime.now(),
      importance: 1,
      title: 'спитати шопського за допомогу медичну фінансову',
      reason: 'якісний пастор гарно говорить',
    ),
    SampleItem(
      id: '2',
      createdAt: DateTime.now().add(const Duration(hours: 2)),
      importance: 2,
      title: 'Д дочитати ХНС',
      reason: 'це круто',
    ),
    SampleItem(
      id: '3',
      createdAt: DateTime.now().add(const Duration(hours: 1)),
      importance: 3,
      title: 'З син червяк',
      reason: 'питає в мами',
    ),
    SampleItem(
      id: '4',
      createdAt: DateTime.now().add(const Duration(hours: 1)),
      importance: 4,
      title: 'О душ',
      reason: 'бути чесним це класно',
    ),
    SampleItem(
        id: '5',
        createdAt: DateTime.now(),
        importance: 1,
        title: 'спитати шопського за допомогу медичну фінансову',
        reason: 'якісний пастор гарно говорить',
        valuesIds: ['1']),
    SampleItem(
      id: '6',
      createdAt: DateTime.now().add(const Duration(hours: 2)),
      importance: 2,
      title: 'Д дочитати ХНС',
      reason: 'це круто',
    ),
    SampleItem(
      id: '7',
      createdAt: DateTime.now().add(const Duration(hours: 1)),
      importance: 3,
      title: 'З син червяк',
      reason: 'питає в мами',
    ),
    SampleItem(
      id: '8',
      createdAt: DateTime.now().add(const Duration(hours: 1)),
      importance: 4,
      title: 'О душ',
      reason: 'бути чесним це класно',
    ),
  ];

  List<Value> values = [Value(id: '1', title: 'гроші')];
  @override
  State<SampleItemListView> createState() => _SampleItemListViewState();
}

class _SampleItemListViewState extends State<SampleItemListView> {
  @override
  void initState() {
    super.initState();
    // modal auth
    WidgetsBinding.instance
        .addPostFrameCallback((_) async => ModalAuth().main(_, context));
  }

  @override
  Widget build(BuildContext context) {
    var topActions = Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            color: Theme.of(context).colorScheme.secondary,
            icon: const Icon(Icons.question_mark_rounded),
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SettingsView(
                          controller: widget.controller,
                        )));
              },
              color: Theme.of(context).colorScheme.secondary,
              icon: const Icon(Icons.settings_sharp)),
        ],
      ),
    );

    return Scaffold(
      appBar: null,
      body: ScreenWrapper(
        onTapAction: () {
          var descriptionFocusNode = FocusNode();
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        TextField(
                          autofocus: true,
                          maxLength: 60,
                          scrollPadding: EdgeInsets.zero,
                          decoration: const InputDecoration(
                              alignLabelWithHint: true,
                              labelText: "що",
                              contentPadding: EdgeInsets.zero,
                              hintText: 'шо будеш робити?'),
                          style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.fontSize,
                          ),
                          onSubmitted: (text) {
                            descriptionFocusNode.requestFocus();
                          },
                        ),
                        TextField(
                          autofocus: true,
                          maxLength: 30,
                          focusNode: descriptionFocusNode,
                          decoration: const InputDecoration(
                              alignLabelWithHint: true,
                              labelText: "чому",
                              contentPadding: EdgeInsets.zero,
                              hintText: 'чому ти це робиш?'),
                          style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.fontSize,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.fast),
          child: Expanded(
            child: Column(
              children: [
                const SizedBox(
                  height: 12,
                ),
                topActions,
                const SizedBox(
                  height: 24,
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  restorationId: 'sampleItemListView',
                  itemCount: widget.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = widget.items[index];
                    return Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16.0),
                        child: SampleItemSimpleView(
                          item: item,
                          key: Key(item.id),
                        ));
                  },
                ),
                const SizedBox(
                  height: 120,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

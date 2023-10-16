import 'package:do_important_zanovo/src/sample_feature/sample_item_simple_view.dart';
import 'package:do_important_zanovo/src/sample_feature/value.dart';
import 'package:do_important_zanovo/src/sample_feature/widgets/modal_auth.dart';
import 'package:do_important_zanovo/src/widgets/screen_wrapper.dart';
import 'package:flutter/material.dart';

import 'sample_item.dart';

/// Displays a list of SampleItems.
class SampleItemListView extends StatefulWidget {
  SampleItemListView({super.key});

  static const routeName = '/';

  List<SampleItem> items = [
    SampleItem(
        id: '1',
        createdAt: DateTime.now(),
        importance: 1,
        title: 'УМ підготуватись до тесту, бо буде бобо, а потім син...',
        reason: 'якісний пастор гарно говорить',
        valuesIds: ['1']),
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
    WidgetsBinding.instance.addPostFrameCallback(ModalAuth().main);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: ScreenWrapper(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.fast),
          child: Expanded(
            child: Column(
              children: [
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.question_mark_rounded),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.settings_sharp))
                    ],
                  ),
                ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

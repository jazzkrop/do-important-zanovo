import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_important_zanovo/src/core/services/db_constants.dart';
import 'package:do_important_zanovo/src/task_feature/task_form.dart';
import 'package:do_important_zanovo/src/task_feature/task_simple_view.dart';
import 'package:do_important_zanovo/src/task_feature/widgets/modal_auth.dart';
import 'package:do_important_zanovo/src/settings/settings_view.dart';
import 'package:do_important_zanovo/src/widgets/screen_wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../core/models/task_model.dart';

/// Displays a list of Tasks.
class TaskListView extends StatefulWidget {
  TaskListView({super.key, this.controller});

  final controller;

  static const routeName = '/';

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  final Stream<QuerySnapshot> tasksStream = FirebaseFirestore.instance
      .collection(DatabasePaths.users)
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection(DatabasePaths.tasks)
      .orderBy(Task.createdAtStr, descending: true)
      .snapshots();

  @override
  void initState() {
    super.initState();
    // modal auth
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ModalAuth().main(context);
    });
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
          createTask(context);
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
                StreamBuilder<QuerySnapshot>(
                    stream: tasksStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        // TODO: create error screen
                        return const Text('помилка.');
                      }
                      // TODO: create loading state
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text("завантаження.");
                      }
                      if (snapshot.data!.docs.length == 0) {
                        return const SizedBox(
                            height: 500, child: Center(child: Text("пусто.")));
                      }
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        restorationId: 'TaskListView',
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item = snapshot.data!.docs[index];
                          return Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16.0),
                              child: TaskSimpleView(
                                task: Task.fromFirestore(
                                    item as DocumentSnapshot<
                                        Map<String, dynamic>>,
                                    SnapshotOptions()),
                                key: Key(item.id),
                              ));
                        },
                      );
                    }),
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

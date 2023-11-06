import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_important_zanovo/src/core/models/task_model.dart';
import 'package:do_important_zanovo/src/core/services/db_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class TaskController {
  var db = FirebaseFirestore.instance;
  var userId = FirebaseAuth.instance.currentUser?.uid;

  createTask({title, reason, importance}) async {
    Task task = Task(
      id: const Uuid().v4(),
      title: title,
      reason: reason,
      importance: importance,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
      doneAt: 0,
    );

    final tasksRef = db
        .collection(DatabasePaths.users)
        .doc(userId)
        .collection(DatabasePaths.tasks)
        .withConverter(
          fromFirestore: Task.fromFirestore,
          toFirestore: (Task task, options) => task.toFirestore(),
        )
        .doc(task.id);

    await tasksRef.set(task);
  }

  editTask(
      {required String id,
      String? title,
      String? reason,
      int? importance,
      Timestamp? doneAt}) async {
    final tasksRef = db
        .collection(DatabasePaths.users)
        .doc(userId)
        .collection(DatabasePaths.tasks)
        .withConverter(
          fromFirestore: Task.fromFirestore,
          toFirestore: (Task task, options) => task.toFirestore(),
        )
        .doc(id);
    Map<String, Object> taskUpdatedData = {};

    if (title != null) {
      taskUpdatedData.addAll({"title": title});
    }
    if (reason != null) {
      taskUpdatedData.addAll({"reason": reason});
    }
    if (importance != null) {
      taskUpdatedData.addAll({"importance": importance});
    }
    if (doneAt != null) {
      taskUpdatedData.addAll({"doneAt": doneAt});
    }
    await tasksRef.update(taskUpdatedData);
  }

  markTaskDone(Task task) async {
    final tasksRef = db
        .collection(DatabasePaths.users)
        .doc(userId)
        .collection(DatabasePaths.tasks)
        .withConverter(
          fromFirestore: Task.fromFirestore,
          toFirestore: (Task task, options) => task.toFirestore(),
        )
        .doc(task.id);

    await tasksRef.update({"doneAt": Timestamp.now()});
  }

  markTaskUndone(Task task) async {
    final tasksRef = db
        .collection(DatabasePaths.users)
        .doc(userId)
        .collection(DatabasePaths.tasks)
        .withConverter(
          fromFirestore: Task.fromFirestore,
          toFirestore: (Task task, options) => task.toFirestore(),
        )
        .doc(task.id);

    await tasksRef.update({"doneAt": 0});
  }

  deleteTask(String id) async {
    final tasksRef = db
        .collection(DatabasePaths.users)
        .doc(userId)
        .collection(DatabasePaths.tasks)
        .doc(id);
    await tasksRef.delete();
  }
}

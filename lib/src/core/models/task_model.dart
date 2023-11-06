import 'package:cloud_firestore/cloud_firestore.dart';

/// A placeholder class that represents an entity or model.
class Task {
  Task({
    required this.id,
    this.createdAt,
    this.updatedAt,
    this.doneAt,
    required this.title,
    this.importance,
    this.reason,
  });

  static String createdAtStr = 'createdAt';
  static String doneAtStr = 'doneAt';

  final String id;
  final Timestamp? createdAt;
  final Timestamp? updatedAt;
  final dynamic? doneAt;
  final String title;
  final int? importance;
  final String? reason;

  factory Task.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return Task(
      id: data?['id'],
      createdAt: data?['createdAt'],
      updatedAt: data?['updatedAt'],
      doneAt: data?['doneAt'],
      title: data?['title'],
      importance: data?['importance'],
      reason: data?['reason'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "title": title,
      if (createdAt != null) "createdAt": createdAt,
      if (updatedAt != null) "updatedAt": updatedAt,
      if (doneAt != null) "doneAt": doneAt,
      if (importance != null) "importance": importance,
      if (reason != null) "reason": reason,
    };
  }
}

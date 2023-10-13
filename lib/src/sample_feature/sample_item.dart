/// A placeholder class that represents an entity or model.
class SampleItem {
  const SampleItem({
    required this.id,
    required this.createdAt,
    this.updatedAt,
    this.doneAt,
    required this.title,
    this.valuesIds,
    required this.importance,
    required this.reason,
  });

  final String id;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? doneAt;
  final String title;
  final List<String>? valuesIds;
  final int importance;
  final String reason;
}

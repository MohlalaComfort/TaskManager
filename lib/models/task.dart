// lib/models/task.dart
class Task {
  String title;
  bool isDone;

  Task({required this.title, this.isDone = false});

  // Convert Task to Map for storage
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isDone': isDone,
    };
  }

  // Create Task from Map
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'],
      isDone: map['isDone'],
    );
  }
}

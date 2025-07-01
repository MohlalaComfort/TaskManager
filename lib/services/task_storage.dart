// lib/services/task_storage.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class TaskStorage extends ChangeNotifier {
  List<Task> _tasks = [];
  late SharedPreferences _prefs;

  List<Task> get tasks => _tasks;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    loadTasks();
  }

  void loadTasks() {
    final tasksString = _prefs.getString('tasks');
    if (tasksString != null) {
      final List decoded = jsonDecode(tasksString);
      _tasks = decoded.map((taskMap) => Task.fromMap(taskMap)).toList();
    }
    notifyListeners();
  }

  void saveTasks() {
    final encoded = jsonEncode(_tasks.map((t) => t.toMap()).toList());
    _prefs.setString('tasks', encoded);
  }

  void addTask(String title) {
    _tasks.add(Task(title: title));
    saveTasks();
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    saveTasks();
    notifyListeners();
  }

  void toggleTask(int index) {
    _tasks[index].isDone = !_tasks[index].isDone;
    saveTasks();
    notifyListeners();
  }
}

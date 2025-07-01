// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'services/task_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final taskStorage = TaskStorage();
  await taskStorage.init();

  runApp(
    ChangeNotifierProvider(
      create: (_) => taskStorage,
      child: const TaskMateApp(),
    ),
  );
}

class TaskMateApp extends StatelessWidget {
  const TaskMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskMate',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blueAccent,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const HomeScreen(),
    );
  }
}

// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/task_storage.dart';
import '../widgets/task_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  void _addTask(BuildContext context) {
    final title = _controller.text.trim();
    if (title.isNotEmpty) {
      Provider.of<TaskStorage>(context, listen: false).addTask(title);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskStorage>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TaskMate'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'New Task',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addTask(context),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _addTask(context),
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: taskProvider.tasks.length,
              itemBuilder: (context, index) {
                final task = taskProvider.tasks[index];
                return TaskTile(
                  title: task.title,
                  isDone: task.isDone,
                  onToggle: () => taskProvider.toggleTask(index),
                  onDelete: () => taskProvider.deleteTask(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

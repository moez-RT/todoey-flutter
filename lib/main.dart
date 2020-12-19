import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/screens/tasks_screen.dart';

import 'models/task.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataTask>(
      create: (_) => DataTask(),
      child: MaterialApp(
        home: TasksScreen(),
      ),
    );
  }
}

class DataTask extends ChangeNotifier {
  List<Task> _tasks = [
    Task(name: 'Do Scrum Backend project'),
    Task(name: 'Do AI projects', isDone: true),
    Task(name: 'Go to Gym'),
  ];

  void addTask(Task task) {
    _tasks.insert(0, task);
    notifyListeners();
  }

  UnmodifiableListView<Task> get tasks {
    _tasks.sort((a, b) => a.isDone == b.isDone
        ? 0
        : a.isDone
        ? 1
        : -1);
    return UnmodifiableListView(_tasks);
  }

  int get tasksCount {
    return _tasks.length;
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }

  void modifiedTask() {
    notifyListeners();
  }
}

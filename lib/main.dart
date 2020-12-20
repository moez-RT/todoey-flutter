import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoey_flutter/screens/tasks_screen.dart';

import 'Database/database_helper.dart';
import 'models/task.dart';

void main() async {
  runApp(MyApp());

}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Task> tasks = [];
  DatabaseHelper dbHelper ;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper.instance;

  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataTask>(
      create: (_) => DataTask(dbHelper),
      child: MaterialApp(
        theme: ThemeData.light().copyWith(
          primaryColor: Colors.lightBlueAccent,
          accentColor: Colors.lightBlueAccent,
          colorScheme: ColorScheme.light(primary: Colors.lightBlueAccent),
          buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
        ),
        home: TasksScreen(),
      ),
    );
  }
}

class DataTask extends ChangeNotifier {
  List<Task> _tasks;
  DatabaseHelper dbHelper;
  DataTask(dbHelper) {
    this.dbHelper = dbHelper;
  }

  void addTask(Task task) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: task.name,
      DatabaseHelper.columnDate: task.date,
      DatabaseHelper.columnIsDone: task.isDone ? 1 : 0
    };
    await dbHelper.insert(row);
    _tasks.insert(0, task);
    notifyListeners();
  }

  Future<UnmodifiableListView<Task>> get tasks async {
      final data = await dbHelper.queryAllRows();
      _tasks = Task.decode(data);



    // _tasks?.sort((a, b) => a.isDone == b.isDone
    //     ? 0
    //     : a.isDone
    //         ? 1
    //         : -1);
    return UnmodifiableListView(_tasks);
  }

  int get tasksCount {
    return _tasks?.length;
  }

  void deleteTask(Task task) async {
    _tasks.remove(task);
    await dbHelper.delete(task.id);

    notifyListeners();
  }

  void modifiedTask(Task task) async {

    Map<String, dynamic> row = {
      DatabaseHelper.columnId: task.id,
      DatabaseHelper.columnName: task.name,
      DatabaseHelper.columnDate: task.date,
      DatabaseHelper.columnIsDone: task.isDone ? 1 : 0
    };
    await dbHelper.update(row);

    notifyListeners();
  }
}


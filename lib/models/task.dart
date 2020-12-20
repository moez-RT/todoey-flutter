import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Task {
  int id;
  String name;
  bool isDone;
  String date;

  Task({@required this.name, this.isDone = false, this.date, this.id});

  void toggleDone() {
    isDone = !isDone;
  }

  static Map<String, dynamic> toMap(Task task) =>
      {'id': task.id, 'name': task.name, 'isDone': task.isDone};

  static String encode(List<Task> tasks) => json.encode(
        tasks.map<Map<String, dynamic>>((task) => Task.toMap(task)).toList(),
      );

  static List<Task> decode(tasks) =>
      tasks.map<Task>((item) => Task.fromMap(item)).toList();

  Task.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    id = map['id'];
    date = map['date'];
    isDone = map['isDone'] == 1 ? true : false;
  }

  factory Task.fromJson(Map<String, dynamic> jsonData) {
    return Task(
      name: jsonData['name'],
      id: jsonData['id'],
      isDone: jsonData['isDone'],
    );
  }
}

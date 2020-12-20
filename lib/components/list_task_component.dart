import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/components/task_component.dart';
import 'package:todoey_flutter/models/task.dart';

import '../main.dart';

class ListTaskComponent extends StatelessWidget {
  final isDone;
  ListTaskComponent({@required this.isDone});
  @override
  Widget build(BuildContext context) {
    List<Task> tasks = [];

    getList() async {
      tasks = await Provider.of<DataTask>(context).tasks;
    }

    return FutureBuilder(
        future: getList(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.none &&
              snap.hasData == null) {
            return Container();
          }
          return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return tasks[index].isDone == isDone? Dismissible(
                    key: UniqueKey(),
                    background: Container(color: Colors.transparent),
                    child: TaskComponent(task: tasks[index], index: index),
                    onDismissed: (direction) {
                      Provider.of<DataTask>(context, listen: false)
                          .deleteTask(tasks[index]);
                    }): Container();
              });
        });
  }
}

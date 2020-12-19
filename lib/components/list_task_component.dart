import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/components/task_component.dart';

import '../main.dart';

class ListTaskComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataTask>(
      builder: (context, taskData, child) {
        return ListView.builder(
            itemCount: taskData.tasksCount,
            itemBuilder: (context, index) {
              return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.transparent),
                  child:
                      TaskComponent(task: taskData.tasks[index], index: index),
                  onDismissed: (direction) {
                    taskData.deleteTask(index);
                  });
            });
      },
    );
  }
}

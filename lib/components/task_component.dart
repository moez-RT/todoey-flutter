import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/models/task.dart';

import '../main.dart';


class TaskComponent extends StatelessWidget {
  final Task task;
  final int index;
  TaskComponent({@required this.task, @required this.index});

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);

    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
          color: task.isDone ? Colors.grey : Colors.lightBlueAccent,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0),
          )),
      child: CheckboxListTile(
        title: Text(
          task.name,
          style: TextStyle(
              color: task.isDone ? Colors.black : Colors.white,
              decoration:
                  task.isDone ? TextDecoration.lineThrough : null,
              decorationColor: Colors.lightBlueAccent,
              fontWeight: task.isDone ? null : FontWeight.bold,
              decorationThickness: 1.5),
        ),
        subtitle: task.date != null? Text(
          task.date,
          style: TextStyle(
              color: task.isDone ? Colors.white : Colors.grey[700],
              fontWeight: task.isDone ? null : FontWeight.bold,),
        ) : null,
        value: task.isDone,
        activeColor: Colors.lightBlueAccent,
        onChanged: (newValue) {
            task.toggleDone();
            Provider.of<DataTask>(context, listen: false).modifiedTask(task);
        },
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}

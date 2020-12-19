import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/models/task.dart';

import '../main.dart';

class AddTaskScreen extends StatelessWidget {
  String newValue = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        margin: EdgeInsets.only(top: 10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'Add Task',
                style: TextStyle(color: Colors.lightBlueAccent, fontSize: 35.0),
              ),
            ),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                newValue = value;
              },
              decoration: InputDecoration(hintText: 'Enter a task'),
            ),
            RaisedButton(
              onPressed: () {
                if (newValue.trim() != '') {
                  Provider.of<DataTask>(context, listen: false).addTask(
                      Task(name: newValue.trim()));
                      Navigator.pop(context);
                }
              },
              color: Colors.lightBlueAccent,
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

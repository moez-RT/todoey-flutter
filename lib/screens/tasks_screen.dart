import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/components/list_task_component.dart';

import '../main.dart';
import 'add_task_screen.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  bool checkedValue = false;

  Widget buildBottomSheet(BuildContext context) {
    return AddTaskScreen();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(context: context, builder: buildBottomSheet);
        },
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 30.0, top: 30.0, bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                      radius: 35.0,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.list_rounded,
                        color: Colors.lightBlueAccent,
                        size: 50.0,
                      )),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Todoey',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 50.0),
                  ),
                  Text(
                    '${Provider.of<DataTask>(context).tasksCount} Tasks',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35.0),
                          topRight: Radius.circular(35.0))),
                  child: Provider.of<DataTask>(context).tasksCount == 0
                      ? Column(
                        children: [
                          Container(
                            height: 150.0,
                              decoration: BoxDecoration(
                                color: Colors.lightBlueAccent,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Center(
                                child: Text(
                                  'List is empty ! ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 35.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                        ],
                      )
                      : ListTaskComponent()),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/components/list_task_component.dart';
import 'package:todoey_flutter/models/task.dart';

import '../main.dart';
import 'add_task_screen.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  bool checkedValue = false;
  PageController _controller;

  Widget buildBottomSheet(BuildContext context) {
    return AddTaskScreen();
  }

  List<String> state = ['To Do', 'Done'];

  List<Task> tasks;

  @override
  void initState() {
    super.initState();
    _controller = new PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getList() async {
      tasks = await Provider.of<DataTask>(context).tasks;
    }

    return FutureBuilder(
        future: getList(),
        builder: (context, snap) {
          return Scaffold(
            backgroundColor: Colors.lightBlueAccent,
            bottomNavigationBar: ConvexAppBar(
              items: [
                TabItem(icon: Icons.highlight_remove_rounded, title: 'To Do'),
                TabItem(icon: Icons.add_circle_outline_rounded, title: 'Add'),
                TabItem(icon: Icons.check_circle_outline_rounded, title: 'Done'),
              ],
              onTap: (int i)  {
                switch(i) {
                    case 0: {
                      _controller.animateToPage(0,
                          duration: kTabScrollDuration,
                          curve: Curves.easeIn);
                    }
                    break;

                    case 2: {
                      _controller.animateToPage(1,
                          duration: kTabScrollDuration,
                          curve: Curves.easeIn);
                    }
                    break;

                    default: {
                      showModalBottomSheet(
                          context: context, builder: buildBottomSheet);
                    }
                    break;
                    }
              },
            ),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(left: 30.0, top: 30.0, bottom: 20.0),
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
                        Container(
                          padding: EdgeInsets.only(right: 45.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                tasks != null ? '${tasks.where((task) => !task.isDone).toList().length}  To Do' : '? Tasks To Do',
                                style: TextStyle(color: Colors.white, fontSize: 16.0),
                              ),
                              Text(
                                tasks != null ? '${tasks.where((task) => task.isDone).toList().length}  Done' : '? Tasks Done',
                                style: TextStyle(color: Colors.white, fontSize: 16.0),
                              ),
                            ],
                          ),
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
                        child: (snap.connectionState != ConnectionState.none ||
                                    snap.hasData != null) &&
                                tasks != null
                            ? tasks.length == 0
                                ? Column(
                                    children: [
                                      Container(
                                        height: 150.0,
                                        decoration: BoxDecoration(
                                          color: Colors.lightBlueAccent,
                                          borderRadius:
                                              BorderRadius.circular(30.0),
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
                                : PageView(
                                    physics: NeverScrollableScrollPhysics(),
                                    controller: _controller,
                                    children: [
                                      ListTaskComponent(
                                        isDone: false,
                                      ),
                                      ListTaskComponent(isDone: true),
                                    ],
                                  )
                            : Center(
                                child: SizedBox(
                                    height: 150.0,
                                    width: 150.0,
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.lightBlueAccent,
                                    )))),
                  )
                ],
              ),
            ),
          );
        });
  }
}

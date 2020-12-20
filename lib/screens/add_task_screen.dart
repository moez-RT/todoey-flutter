import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/models/task.dart';

import '../main.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}
// var moonLanding = DateTime.parse("1969-07-20 20:18:04Z");  // 8:18pm

class _AddTaskScreenState extends State<AddTaskScreen> {
  String newValue;
  DateTime date;
  final DateFormat formatter = DateFormat('yyyy/MM/dd');

  @override
  void initState() {
    super.initState();
    newValue = '';
    date =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  }

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
              textAlign: TextAlign.center,
              onChanged: (value) {
                newValue = value;
              },
              decoration: InputDecoration(
                  hintText: 'Enter a task',
                  prefixIcon: Icon(Icons.insert_drive_file_rounded)),
            ),
            TextField(
              onTap: () async {
                final newDate = await showDatePicker(
                  context: context,
                  initialDate: date,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                );
                if (newDate != null) {
                  setState(() {
                    date = newDate;
                  });
                }
              },
              readOnly: true,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: formatter.format(date),
                prefixIcon: Icon(
                  Icons.today_rounded,
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {
                if (newValue.trim() != '') {
                  Provider.of<DataTask>(context, listen: false)
                      .addTask(Task(name: newValue.trim(), date: formatter.format(date)));
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

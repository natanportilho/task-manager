import 'package:flutter/material.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/stores/task_store.dart';

class AlarmPage extends StatefulWidget {
  AlarmPage(this.todo);
  final Task todo;

  @override
  _AlarmPageState createState() => _AlarmPageState(todo);
}

class _AlarmPageState extends State<AlarmPage> {
  int hour = 0;
  int minute = 0;

  TaskStore taskStore;
  _AlarmPageState(this.todo);
  Task todo;
  List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(),
            body: Material(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "AM",
                              style: TextStyle(
                                fontSize: 32.0,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            //
                            //borderRadius:
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "PM",
                              style: TextStyle(
                                fontSize: 32.0,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                    Container(
                        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                            child: IconButton(
                              onPressed: () => {
                                _changeHour(true),
                              },
                              icon: Icon(Icons.arrow_drop_up),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                            child: IconButton(
                              onPressed: () => {
                                _changeHour(false),
                              },
                              icon: Icon(Icons.arrow_drop_up),
                            ),
                          ),
                        ),
                      ],
                    )),
                    Container(
                        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                            child: Text(hour.toString(),
                                style: TextStyle(
                                  fontSize: 32.0,
                                  decoration: TextDecoration.none,
                                )),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                            child: Text("00",
                                style: TextStyle(
                                  fontSize: 32.0,
                                  decoration: TextDecoration.none,
                                )),
                          ),
                        ),
                      ],
                    )),
                    Container(
                        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                            child: IconButton(
                              onPressed: () => {
                                _changeHour(false),
                              },
                              icon: Icon(Icons.arrow_drop_down),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                            child: IconButton(
                              onPressed: () => {
                                _changeHour(false),
                              },
                              icon: Icon(Icons.arrow_drop_down),
                            ),
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            )));

    //         child: Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //  children: <Widget>[_createDescriptionField()],
    // )
  }

  _changeHour(bool increase) {
    setState(() {
      if (increase) {
        hour += 1;
        if (hour > 12) {
          hour = 0;
        }
      } else {
        hour -= 1;
        if (hour < 0) {
          hour = 12;
        }
      }
      print(hour);
    });
  }

   _changeMinute(bool increase) {
    setState(() {
      if (increase) {
        minute += 1;
        if (hour > 12) {
          hour = 0;
        }
      } else {
        hour -= 1;
        if (hour < 0) {
          hour = 12;
        }
      }
      print(hour);
    });
  }

  AppBar buildAppBar() {
    return AppBar();
  }
}

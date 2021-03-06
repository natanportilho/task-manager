import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/pages/select_category_page.dart';
import 'package:task_manager/stores/task_store.dart';

import '../main.dart';

class TodoPage extends StatefulWidget {
  TodoPage(this.todo);
  final Task todo;

  @override
  _TodoPageState createState() => _TodoPageState(todo);
}

class _TodoPageState extends State<TodoPage> {
  TaskStore taskStore;
  _TodoPageState(this.todo);
  Task todo;
  List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    taskStore = Provider.of<TaskStore>(context);
    return FutureBuilder(
      future: _updateCategory(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: buildAppBar(),
            body: SingleChildScrollView(
                child:
                    Observer(builder: (_) => _buildTodoInfoSection(context))),
            bottomNavigationBar: BottomAppBar(
              color: Colors.transparent,
              child: Observer(builder: (_) => _buildActionsButtons(context)),
              elevation: 0,
            ),
          );
        } else if (snapshot.hasError) {
          return new Text('Error: ${snapshot.error}');
        }
        return Scaffold(
          appBar: buildAppBar(),
          body: _buildSpinnerScreen(),
        );
      },
    );
  }

  _buildSpinnerScreen() {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 100.0),
              child: Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.indigo,
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Colors.indigoAccent))),
            ),
          ],
        ),
      ],
    );
  }

  //todo: check this;
  Future _updateCategory() async {
    var completer = new Completer<String>();
    completer.complete("a");
    return completer.future;
  }

  Column _buildTodoInfoSection(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildCircleAvatar(todo),
        _buildCategoryText(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: Container(
              height: 200,
              child: buildDescriptionText(),
            ),
          ),
        ),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar();
  }

  Row _buildActionsButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _buildDoneButton(),
        _buildAlarmButton(),
        _buildRemoveButton(context),
      ],
    );
  }

  IconButton _buildRemoveButton(BuildContext context) {
    return IconButton(
        onPressed: () => {taskStore.remove(todo), Navigator.pop(context)},
        icon: Icon(Icons.delete));
  }

  IconButton _buildDoneButton() {
    return IconButton(
      onPressed: () => {
        _toggleDoneFlag(todo),
      },
      icon: Icon(Icons.done),
      color: todo.done ? Colors.green : Colors.indigo,
    );
  }

  IconButton _buildAlarmButton() {
    var selectedTime, selectedDateTime, now;

    return IconButton(
      onPressed: () async => {
        selectedTime = await showTimePicker(
          initialTime: TimeOfDay.now(),
          context: context,
        ),
        if (selectedTime != null)
          {
            now = DateTime.now(),
            selectedDateTime = DateTime(now.year, now.month, now.day,
                selectedTime.hour, selectedTime.minute),
            _scheduleNotification(selectedDateTime),
          }
      },
      icon: Icon(Icons.alarm_off),
    );
  }

  Card buildDescriptionText() {
    return Card(
        margin: EdgeInsets.all(20.0),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 5,
            initialValue: todo.description,
            textInputAction: TextInputAction.newline,
            onChanged: (text) {
              taskStore.updateDescription(todo, text);
            },
            decoration:
                InputDecoration.collapsed(hintText: "Enter the description"),
          ),
        ));
  }

  Text _buildCategoryText() {
    return Text(
      todo.category.name.toString(),
      style: GoogleFonts.ibarraRealNova(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        textStyle: TextStyle(letterSpacing: .5),
      ),
    );
  }

  Padding _buildCircleAvatar(Task todo) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: _getCategoryImage(todo.category.imageUrl),
        onTap: () => {_goToSelectCategoryPage(todo)},
      ),
    );
  }

  Future _goToSelectCategoryPage(Task todo) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectCategoryPage(todo),
        ));
  }

  CircleAvatar _getCategoryImage(String imageUrl) {
    if (imageUrl == '')
      return _buildPlaceholderCategoryImage();
    else
      return _buildCategoryImage(imageUrl);
  }

  CircleAvatar _buildCategoryImage(String imageUrl) {
    return CircleAvatar(
      backgroundImage: NetworkImage(imageUrl),
      radius: 50,
    );
  }

  CircleAvatar _buildPlaceholderCategoryImage() {
    return CircleAvatar(
      backgroundColor: Colors.black26,
      child: Text('Loading'),
      radius: 50,
    );
  }

  _toggleDoneFlag(Task task) {
    taskStore.toggleTodo(task);
  }

  Future<void> _scheduleNotification(
      DateTime scheduledNotificationDateTime) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'ic_launcher',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),
    );

    var iOSPlatformChannelSpecifics =
        IOSNotificationDetails(sound: 'slow_spring_board.aiff');
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(
        0,
        'You have stuff todo!',
        todo.description,
        scheduledNotificationDateTime,
        platformChannelSpecifics);

    _showFeedbackMessage();
  }

  _showFeedbackMessage() {
    Fluttertoast.showToast(
        msg: "We will notify you when it's time to do this task :)",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

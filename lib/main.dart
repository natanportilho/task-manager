import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/services/notifications_service.dart';
import 'package:task_manager/stores/store_category.dart';
import 'package:task_manager/stores/task_store.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

import 'pages/home_page.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
var providers = [
  Provider<TaskStore>(create: (_) => TaskStore()),
  Provider<CategoryStore>(create: (_) => CategoryStore())
];

void main() {
  _initializeLocalNotifications();
  runApp(
    MultiProvider(providers: providers, child: MyApp()),
  );
}

_initializeLocalNotifications() async {
  NotificationsService notificationsService = NotificationsService();
  notificationsService.initializeLocalNotifications();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => new ThemeData(
              primarySwatch: Colors.red,
              brightness: brightness,
            ),
        themedWidgetBuilder: (context, theme) {
          return new MaterialApp(
            title: 'Task Manager',
            theme: theme,
            home: MyHomePage(),
          );
        });
  }
}

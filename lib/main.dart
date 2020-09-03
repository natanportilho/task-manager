import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/services/notifications_service.dart';
import 'package:task_manager/services/theme_service.dart';
import 'package:task_manager/stores/store_category.dart';
import 'package:task_manager/stores/task_store.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

import 'models/color_theme_model.dart';
import 'pages/home_page.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
var theme;
ThemeData themeData;
ColorTheme colorTheme;
var providers = [
  Provider<TaskStore>(create: (_) => TaskStore()),
  Provider<CategoryStore>(create: (_) => CategoryStore())
];

Future<void> main() async {
  await _initializeLocalNotifications();
  runApp(
    MultiProvider(providers: providers, child: MyApp()),
  );
}

_initializeLocalNotifications() async {
  NotificationsService notificationsService = NotificationsService();
  notificationsService.initializeLocalNotifications();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  theme = prefs.getString("theme") != null ? prefs.getString("theme") : "green";
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildApp();
  }

  DynamicTheme _buildApp() {
    ThemeService themeService = ThemeService();
    colorTheme =
        themeService.createColorsList().where((c) => c.name == theme).first;

    return new DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => _buildThemeData(brightness),
        themedWidgetBuilder: (context, theme) {
          return _buildMaterialApp(themeData);
        });
  }

  ThemeData _buildThemeData(Brightness brightness) {
    themeData = new ThemeData(
      primarySwatch: colorTheme.primaryColor,
      accentColor: colorTheme.secondaryColor,
      brightness: brightness,
    );
    return themeData;
  }

  MaterialApp _buildMaterialApp(ThemeData themeData) {
    return new MaterialApp(
      title: 'Task Manager',
      theme: themeData,
      home: MyHomePage(),
    );
  }
}

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:trafficnow/module/userPlace.dart';

// Support only for IOS
void requestIOS(FlutterLocalNotificationsPlugin plugin) {
  plugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        sound: true,
      );
}

initializeNotifications(FlutterLocalNotificationsPlugin plugin) async {
  var initializationSettingsIOS = IOSInitializationSettings();
  var initializationSettings =
      InitializationSettings(null, initializationSettingsIOS);
  await plugin.initialize(initializationSettings);
}

Future<void> scheduleNotification(
    FlutterLocalNotificationsPlugin plugin, UserPlace userPlace, int id) async {
  var hour = userPlace.date.hour;
  var minute = userPlace.date.minute;

  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics =
      NotificationDetails(null, iOSPlatformChannelSpecifics);

  await plugin.showDailyAtTime(
      id,
      "${DateFormat.jm().format(userPlace.date)}",
      "Your current Est Time for ${userPlace.dest} is {time}",
      Time(hour, minute, 0),
      platformChannelSpecifics);
}

import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/src/date_time.dart';

class LocalNotification {
  Key? key;
  late String title;
  late String message;
  String payload;
  String appIcon;
  MaterialPageRoute pageRoute;
  BuildContext context;
  bool iosRequestSoundPermission;
  bool iosRequestBadgePermission;
  bool iosRequestAlertPermission;
  FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  dynamic initializationSettingAndroid;
  dynamic initializationSettingIos;
  dynamic initializationSetting;

  Random random = Random();

  LocalNotification({
    required this.context,
    required this.pageRoute,
    required this.appIcon,
    required this.payload,
    this.iosRequestSoundPermission = false,
    this.iosRequestBadgePermission = false,
    this.iosRequestAlertPermission = false,
  }) {
    initializationSettingAndroid = AndroidInitializationSettings(appIcon);

    initializationSettingIos = DarwinInitializationSettings(
        requestSoundPermission: iosRequestSoundPermission,
        requestBadgePermission: iosRequestBadgePermission,
        requestAlertPermission: iosRequestAlertPermission,
        onDidReceiveLocalNotification: onDidReceiveNotification);

    initializationSetting = InitializationSettings(
        android: initializationSettingAndroid, iOS: initializationSettingIos);

    localNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: didReceiveNotification);
  }

  Future<void> setup() async {
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(
      tz.getLocation(currentTimeZone),
    );
  }

  Future requestPermission() async {
    return await localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<dynamic> didReceiveNotification(NotificationResponse details) async {
    await Navigator.push(context, pageRoute);
  }

  Future<void> onDidReceiveNotification(id, title, body, payload) async {
    await showDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: title,
        content: Text(body),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Ok'),
            onPressed: () async {
              await Navigator.push(context, pageRoute);
            },
          )
        ],
      ),
    );
  }

  Future show(
      {required title,
      required message,
      channelName = 'channel name',
      channelID = 'channel id',
      channelDescription = 'channel description',
      importance = Importance.high,
      priority = Priority.high,
      ticker = 'test ticker'}) async {
    if (title == null && message == null) {
      throw "Missing parameters, title: message";
    } else {
      this.title = title;
      this.message = message;

      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channelID,
        channelName,
        channelDescription: channelDescription,
        importance: importance,
        priority: priority,
        ticker: ticker,
      );

      var iosPlatformChannelSpecifics = const DarwinNotificationDetails();

      var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iosPlatformChannelSpecifics,
      );

      await localNotificationsPlugin.show(
        0 + random.nextInt(9 - 0),
        title,
        message,
        platformChannelSpecifics,
        payload: payload,
      );
    }
  }

  Future showPeriodically(
      {required title,
      required message,
      RepeatInterval repeat = RepeatInterval.everyMinute,
      channelName = 'periodically channel name',
      channelID = 'periodically channel id',
      channelDescription = 'periodically channel description',
      importance = Importance.high,
      priority = Priority.high,
      ticker = 'test ticker'}) async {
    if (title == null && message == null) {
      throw "Missing parameters, title: message, repeat interval";
    } else {
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          channelID, channelName,
          channelDescription: channelDescription);
      var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
      var platformChannelSpecifics = NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: iOSPlatformChannelSpecifics);
      await localNotificationsPlugin.periodicallyShow(
          20 + random.nextInt(29 - 20),
          title,
          message,
          repeat,
          platformChannelSpecifics);
    }
  }

  Future scheduleNotification(
      {required title,
      required message,
      required TZDateTime scheduleDate,
      channelName = 'periodically channel name',
      channelID = 'periodically channel id',
      channelDescription = 'periodically channel description',
      importance = Importance.high,
      priority = Priority.high,
      ticker = 'test ticker'}) async {
    if (title == null && message == null) {
      throw "Missing parameters, title: message, repeat interval";
    } else {
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          channelID, channelName,
          channelDescription: channelDescription);
      var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
      var platformChannelSpecifics = NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: iOSPlatformChannelSpecifics);
      await localNotificationsPlugin.zonedSchedule(10 + random.nextInt(19 - 10),
          title, message, scheduleDate, platformChannelSpecifics,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.time);
    }
  }

  Future retrievePendingNotifications() async {
    return await localNotificationsPlugin.pendingNotificationRequests();
  }

  Future cancel(int index) async {
    await localNotificationsPlugin.cancel(index);
  }

  Future cancelAll() async {
    localNotificationsPlugin.cancelAll();
  }

  Future getDetailsIfAppWasLaunchedViaNotification() async {
    return localNotificationsPlugin.getNotificationAppLaunchDetails();
  }
}

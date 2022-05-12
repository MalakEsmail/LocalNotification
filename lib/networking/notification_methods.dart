import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

class NotificationMethods {
  static final notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();
  // first step : init notification =>(1)
  static Future init({bool initScedule = false}) async {
    final android = AndroidInitializationSettings('dog');
    final ios = IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: null);
    final settings = InitializationSettings(android: android, iOS: ios);
    await notifications.initialize(settings,
        onSelectNotification: ((payload) async {
      onNotifications.add(payload);
    }));
  }

  // second step : show notification =>(2)
  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payLoad,
  }) async {
    await notifications
        .show(id, title, body, await getNotificationDetails(), payload: payLoad)
        .catchError((ex) {
      print("**************");
      print(ex.toString());
      print("**************");
    });
  }

  // used in step 2 => show notification
  static Future getNotificationDetails() async {
    return NotificationDetails(
        android: AndroidNotificationDetails(
          "channelId",
          "channelName",
          channelDescription: "",
          importance: Importance.max,
        ),
        iOS: IOSNotificationDetails());
  }
}

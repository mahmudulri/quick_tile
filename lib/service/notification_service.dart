import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class FreeNotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool isPremium = true;

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('flutter_logo');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {},
    );
  }

  notificationDetails() {
    // final UserController userController = Get.put(UserController());

    return const NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId',
          'channelName',
          importance: Importance.high,
        ),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {String? title, String? body, String? payLoad}) async {
    int id = DateTime.now().millisecondsSinceEpoch.hashCode;
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }
}

class PremiumNotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool isPremium = true;

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('flutter_logo');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {},
    );
  }

  notificationDetails() {
    // final UserController userController = Get.put(UserController());
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId',
          'channelName',
          importance: Importance.high,
          priority: Priority.high,
          ongoing: true,
        ),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {String? title, String? body, String? payLoad}) async {
    int id = DateTime.now().millisecondsSinceEpoch.hashCode;
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  // Future showNotification(
  //     {int id = 0, String? title, String? body, String? payLoad}) async {
  //   return notificationsPlugin.show(
  //       id, title, body, await notificationDetails());
  // }
}




//...................................//


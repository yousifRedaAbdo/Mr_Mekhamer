import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  // Singleton pattern
  static final NotificationService _notificationService =
      NotificationService._internal();
  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  // Instance of FlutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialize settings for Android and iOS
  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("ic_launcher");

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Handle notification when app is in foreground
  Future onDidReceiveLocalNotification(
    int id,
    String title,
    String body,
    String payload,
  ) async {
    // Your logic here
  }

  // Handle notification when user taps on it
  Future onSelectNotification(String payload) async {
    // Your logic here
  }

  // Show a simple notification
  Future<void> showNotification(title, body) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      "myChannelId",
      'channel name',
      channelDescription: 'channel description',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
      enableVibration: false,
      showWhen: true,
    );
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      DateTime.now().minute,
      title,
      body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  getUserNotifications({required String token}) async {
    try {

      Response response = await Dio().get(
        'https://academy2022.nitg-eg.com/mohamedmekhemar/signleteacher/apis.php?token=$token&function=get_user_notifications',
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return 'fail';
      }
    } catch (error) {
      return 'fail';
    }
  }
}

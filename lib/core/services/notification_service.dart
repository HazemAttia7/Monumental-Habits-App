import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final notificationsPlugin = FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  Future<void> init() async {
    if (_isInitialized) return;

    const initSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const initSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );

    await notificationsPlugin.initialize(settings: initSettings);

    await notificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();
    _isInitialized = true;
  }

  NotificationDetails getNotificationDetails() => const NotificationDetails(
    android: AndroidNotificationDetails(
      'reminders_channel_id',
      'Reminders Notifications',
      channelDescription: 'Notifications for reminders channel',
      importance: Importance.max,
      priority: Priority.high,
    ),
    iOS: DarwinNotificationDetails(),
  );

  Future<void> showNotification({
     int id = 0,
     String? title,
     String? body,
  }) async {
    await notificationsPlugin.show(
      id : id,
      title : title,
      body : body,
      notificationDetails: getNotificationDetails(),
    );
  }
}
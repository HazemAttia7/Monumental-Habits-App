import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  final notificationsPlugin = FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  Future<void> init() async {
    if (_isInitialized) return;

    tz.initializeTimeZones();
    try {
      final TimezoneInfo currentTimeZone =
          await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(currentTimeZone.identifier));
    } catch (e) {
      // Fallback to UTC if timezone detection fails
      tz.setLocalLocation(tz.UTC);
    }

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
          AndroidFlutterLocalNotificationsPlugin
        >()
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
      id: id,
      title: title,
      body: body,
      notificationDetails: getNotificationDetails(),
    );
  }

  Future<void> scheduleNotification({
    required int id,
    required DateTime date,
    required String title,
    required String body,
  }) async {
    var scheduledDate = tz.TZDateTime(
      tz.local,
      date.year,
      date.month,
      date.day,
      date.hour,
      date.minute,
      date.second,
      date.millisecond,
      date.microsecond,
    );

    await notificationsPlugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduledDate,
      notificationDetails: getNotificationDetails(),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  Future<void> scheduleHabitReminders(Habit habit) async {
    // First cancel any existing notifications for this habit
    await cancelHabitReminders(habit.id);

    for (final reminder in habit.reminders) {
      for (final day in habit.frequency) {
        // Parse reminder time e.g. "5:00 AM"
        final time = _parseReminderTime(reminder);

        // Find next occurrence of this weekday
        final nextDate = _nextWeekday(day, time.hour, time.minute);

        // Unique id per habit+day+reminder combination
        final notifId = _notificationId(
          habit.id,
          day,
          reminder,
          habit.reminders,
        );

        await scheduleNotification(
          id: notifId,
          date: nextDate,
          title: '⏰ ${habit.name}',
          body: 'Time to work on your habit!',
        );
      }
    }
  }

  Future<void> cancelHabitReminders(String habitId) async {
    // Cancel all possible notification ids for this habit
    for (int day = 0; day < 7; day++) {
      for (int reminder = 0; reminder < 12; reminder++) {
        await notificationsPlugin.cancel(
          id: _notificationIdRaw(habitId, day, reminder),
        );
      }
    }
  }

  // ── Helpers ─────────────────────────────────────────────────

  // Converts "5:00 AM" → TimeOfDay
  TimeOfDay _parseReminderTime(String reminder) {
    final parts = reminder.split(' ');
    final hm = parts[0].split(':');
    int hour = int.parse(hm[0]);
    final int minute = int.parse(hm[1]);
    final bool isPm = parts[1] == 'PM';

    if (isPm && hour != 12) hour += 12;
    if (!isPm && hour == 12) hour = 0;

    return TimeOfDay(hour: hour, minute: minute);
  }

  // Gets next occurrence of a weekday (0=Sun...6=Sat) at given time
  DateTime _nextWeekday(int targetDay, int hour, int minute) {
    final now = DateTime.now();
    // Convert your 0=Sun system to DateTime's 1=Mon...7=Sun
    final dartDay = targetDay == 0 ? 7 : targetDay;
    int daysUntil = (dartDay - now.weekday + 7) % 7;

    // If today is the day but time has passed, schedule for next week
    if (daysUntil == 0) {
      final todayTime = DateTime(now.year, now.month, now.day, hour, minute);
      if (todayTime.isBefore(now)) daysUntil = 7;
    }

    final date = now.add(Duration(days: daysUntil));
    return DateTime(date.year, date.month, date.day, hour, minute);
  }

  // Stable unique int id from habitId + day + reminder index
  int _notificationId(
    String habitId,
    int day,
    String reminder,
    List<String> allReminders,
  ) {
    final index = allReminders.indexOf(reminder);
    return _notificationIdRaw(
      habitId,
      day,
      index == -1 ? reminder.hashCode : index,
    );
  }

  int _notificationIdRaw(String habitId, int day, int reminderIndex) {
    return (habitId.hashCode + day * 100 + reminderIndex).abs() % 2147483647;
  }
}

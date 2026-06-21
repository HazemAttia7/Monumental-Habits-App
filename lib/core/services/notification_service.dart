import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:pixel_true_app/features/settings/data/models/notification_settings_model.dart';
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

  // ── Notification details ───────────────────────────────────

  // Original — stays exactly as-is, untouched
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

  // New — adds sound/vibration support
  NotificationDetails getNotificationDetailsWithSettings(
    NotificationSettings settings,
  ) => NotificationDetails(
    android: AndroidNotificationDetails(
      'reminders_channel_id',
      'Reminders Notifications',
      channelDescription: 'Notifications for reminders channel',
      importance: Importance.max,
      priority: Priority.high,
      playSound: settings.soundEnabled,
      enableVibration: settings.vibrationEnabled,
    ),
    iOS: DarwinNotificationDetails(presentSound: settings.soundEnabled),
  );

  // ── Show / Schedule ─────────────────────────────────────────

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

  // Original — stays exactly as-is, untouched
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

  // New — adds settings support
  Future<void> scheduleNotificationWithSettings({
    required int id,
    required DateTime date,
    required String title,
    required String body,
    required NotificationSettings settings,
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
      notificationDetails: getNotificationDetailsWithSettings(settings),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  // ── Habit reminders ─────────────────────────────────────────

  // Original — stays exactly as-is, untouched
  Future<void> scheduleHabitReminders(Habit habit) async {
    await cancelHabitReminders(habit.id);

    for (final reminder in habit.reminders) {
      for (final day in habit.frequency) {
        final time = _parseReminderTime(reminder);
        final nextDate = _nextWeekday(day, time.hour, time.minute);
        final notifId = _notificationId(
          habit.id,
          day,
          reminder,
          habit.reminders,
        );

        await scheduleNotification(
          id: notifId,
          date: nextDate,
          title: '${habit.name} ⏰',
          body: 'Time to work on your habit!',
        );
      }
    }
  }

  // New — adds settings support (master switch, quiet hours, sound, vibration)
  Future<void> scheduleHabitRemindersWithSettings(
    Habit habit,
    NotificationSettings settings,
  ) async {
    await cancelHabitReminders(habit.id);

    if (!settings.masterEnabled) return;

    for (final reminder in habit.reminders) {
      for (final day in habit.frequency) {
        final time = _parseReminderTime(reminder);

        if (settings.quietHoursEnabled && _isInQuietHours(time, settings)) {
          continue;
        }

        final nextDate = _nextWeekday(day, time.hour, time.minute);
        final notifId = _notificationId(
          habit.id,
          day,
          reminder,
          habit.reminders,
        );

        await scheduleNotificationWithSettings(
          // ← fixed, was calling old method
          id: notifId,
          date: nextDate,
          title: '${habit.name} ⏰',
          body: 'Time to work on your habit!',
          settings: settings,
        );
      }
    }
  }

  bool _isInQuietHours(TimeOfDay time, NotificationSettings settings) {
    final start = _parseReminderTime(settings.quietHoursStart);
    final end = _parseReminderTime(settings.quietHoursEnd);

    final timeMinutes = time.hour * 60 + time.minute;
    final startMinutes = start.hour * 60 + start.minute;
    final endMinutes = end.hour * 60 + end.minute;

    if (startMinutes < endMinutes) {
      return timeMinutes >= startMinutes && timeMinutes < endMinutes;
    } else {
      return timeMinutes >= startMinutes || timeMinutes < endMinutes;
    }
  }

  Future<void> cancelHabitReminders(String habitId) async {
    for (int day = 0; day < 7; day++) {
      for (int reminder = 0; reminder < 12; reminder++) {
        await notificationsPlugin.cancel(
          id: _notificationIdRaw(habitId, day, reminder),
        );
      }
    }
  }

  // ── Helpers ─────────────────────────────────────────────────

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

  DateTime _nextWeekday(int targetDay, int hour, int minute) {
    final now = DateTime.now();
    final dartDay = targetDay == 0 ? 7 : targetDay;
    int daysUntil = (dartDay - now.weekday + 7) % 7;

    if (daysUntil == 0) {
      final todayTime = DateTime(now.year, now.month, now.day, hour, minute);
      if (todayTime.isBefore(now)) daysUntil = 7;
    }

    final date = now.add(Duration(days: daysUntil));
    return DateTime(date.year, date.month, date.day, hour, minute);
  }

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

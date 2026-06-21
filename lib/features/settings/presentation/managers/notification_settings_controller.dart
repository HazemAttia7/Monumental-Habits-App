import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/services/notification_service.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:pixel_true_app/features/settings/data/models/notification_settings_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationSettingsController extends ChangeNotifier {
  static const String _key = 'notification_settings';

  final NotificationService _notificationService;
  final List<Habit> Function()
  _getHabits; // pull current habits when rescheduling

  NotificationSettingsController({
    required NotificationService notificationService,
    required List<Habit> Function() getHabits,
  }) : _notificationService = notificationService,
       _getHabits = getHabits {
    _loadSettings();
  }

  NotificationSettings _settings = NotificationSettings();
  NotificationSettings get settings => _settings;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_key);
    if (json != null) {
      _settings = NotificationSettings.fromJson(jsonDecode(json));
    }
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(_settings.toJson()));
  }

  Future<void> toggleMasterSwitch(bool enabled) async {
    _settings = _settings.copyWith(masterEnabled: enabled);
    notifyListeners();
    await _saveSettings();
    await _rescheduleAll();
  }

  Future<void> toggleQuietHours(bool enabled) async {
    _settings = _settings.copyWith(quietHoursEnabled: enabled);
    notifyListeners();
    await _saveSettings();
    await _rescheduleAll();
  }

  Future<void> toggleSound(bool enabled) async {
    _settings = _settings.copyWith(soundEnabled: enabled);
    notifyListeners();
    await _saveSettings();
    await _rescheduleAll();
  }

  Future<void> toggleVibration(bool enabled) async {
    _settings = _settings.copyWith(vibrationEnabled: enabled);
    notifyListeners();
    await _saveSettings();
    await _rescheduleAll();
  }

  Future<void> setQuietHours({
    required String start,
    required String end,
  }) async {
    _settings = _settings.copyWith(quietHoursStart: start, quietHoursEnd: end);
    notifyListeners();
    await _saveSettings();
    await _rescheduleAll();
  }

  Future<void> _rescheduleAll() async {
    final habits = _getHabits();
    for (final habit in habits) {
      if (habit.reminders.isNotEmpty) {
        await _notificationService.scheduleHabitRemindersWithSettings(
          habit,
          _settings,
        );
      } else {
        await _notificationService.cancelHabitReminders(habit.id);
      }
    }
  }
}

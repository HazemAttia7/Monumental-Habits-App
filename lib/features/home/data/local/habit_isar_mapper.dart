import 'dart:convert';
import 'package:pixel_true_app/core/enums/habit_comletion_state_enum.dart';
import 'package:pixel_true_app/features/home/data/local/habit_isar.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';

extension HabitIsarMapper on HabitIsar {
  Habit toDomain() {
    final decoded = jsonDecode(logsJson) as Map<String, dynamic>;
    final logs = decoded.map(
      (date, status) =>
          MapEntry(date, HabitCompletionParser.fromString(status)),
    );
    return Habit(
      id: habitId,
      name: name,
      frequency: frequency,
      reminders: reminders,
      logs: logs,
    );
  }
}

extension HabitDomainMapper on Habit {
  HabitIsar toIsar({
    required String uid,
    bool isSynced = false,
    bool isDeleted = false,
  }) {
    return HabitIsar()
      ..habitId = id
      ..uid = uid
      ..name = name
      ..frequency = frequency
      ..reminders = reminders
      ..logsJson = jsonEncode(logs.map((k, v) => MapEntry(k, v.name)))
      ..isSynced = isSynced
      ..isDeleted = isDeleted
      ..updatedAt = DateTime.now();
  }
}

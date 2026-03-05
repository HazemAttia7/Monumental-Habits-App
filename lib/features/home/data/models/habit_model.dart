import 'package:pixel_true_app/core/enums/habit_comletion_state_enum.dart';
import 'package:pixel_true_app/core/helper/date_helper.dart';

class Habit {
  final String id;
  final String name;
  final List<int> frequency; // [0,1,2,3,4,5] = Sun-Sat (DateTime.weekday)
  final List<String> reminders; // ["05:00", "21:00"]
  final Map<String, enHabitCompletionState>
  logs; // {"2025-01-17": HabitStatus.complete}

  Habit({
    required this.id,
    required this.name,
    required this.frequency,
    required this.reminders,
    required this.logs,
  });

  /// 1–10 score calculated from consistency in the last 30 days
  int get easinessScore {
    final now = DateTime.now();
    int scheduled = 0;
    int completed = 0;

    for (int i = 0; i < 30; i++) {
      final day = now.subtract(Duration(days: i));
      if (!isScheduledOn(day)) continue;

      scheduled++;
      final status = logs[dateKey(day)];
      if (status == enHabitCompletionState.complete ||
          status == enHabitCompletionState.partial) {
        completed++;
      }
    }

    if (scheduled == 0) return 0;
    return ((completed / scheduled) * 9 + 1).round().clamp(1, 10);
  }

  int get currentStreak {
    int streak = 0;
    DateTime day = DateTime.now();
    while (true) {
      // Skip non-scheduled days
      if (!isScheduledOn(day)) {
        day = day.subtract(const Duration(days: 1));
        continue;
      }
      final status = logs[dateKey(day)];
      if (status == enHabitCompletionState.complete ||
          status == enHabitCompletionState.partial) {
        streak++;
        day = day.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }
    return streak;
  }

  int get longestStreak {
    int longest = 0, current = 0;
    final sortedKeys = logs.keys.toList()..sort();
    for (final key in sortedKeys) {
      final day = DateTime.parse(key);
      if (!isScheduledOn(day)) continue;

      final status = logs[key]!;
      if (status != enHabitCompletionState.none) {
        current++;
        if (current > longest) longest = current;
      } else {
        current = 0;
      }
    }
    return longest;
  }

  /// Only counts scheduled days as denominator
  double get completionRate {
    final scheduledLogs = logs.entries.where((e) {
      final day = DateTime.parse(e.key);
      return isScheduledOn(day);
    });
    if (scheduledLogs.isEmpty) return 0;
    final done = scheduledLogs
        .where(
          (e) =>
              e.value == enHabitCompletionState.complete ||
              e.value == enHabitCompletionState.partial,
        )
        .length;
    return (done / scheduledLogs.length) * 100;
  }

  // ── Serialization ───────────────────────────────────────────

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      frequency: List<int>.from(json['frequency'] ?? []),
      reminders: List<String>.from(json['reminders'] ?? []),
      logs: (json['logs'] as Map<String, dynamic>? ?? {}).map(
        (date, status) =>
            MapEntry(date, HabitCompletionParser.fromString(status)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'frequency': frequency,
    'reminders': reminders,
    'logs': logs.map((date, status) => MapEntry(date, status.name)),
  };

  Habit copyWith({
    String? name,
    List<int>? frequency,
    List<String>? reminders,
    Map<String, enHabitCompletionState>? logs,
  }) {
    return Habit(
      id: id,
      name: name ?? this.name,
      frequency: frequency ?? this.frequency,
      reminders: reminders ?? this.reminders,
      logs: logs ?? this.logs,
    );
  }

  bool isScheduledOn(DateTime date) {
    final weekday = date.weekday == 7 ? 0 : date.weekday; // Sun=7 → 0
    return frequency.contains(weekday);
  }
}

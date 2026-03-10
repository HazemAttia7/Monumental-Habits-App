import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pixel_true_app/core/enums/habit_enums.dart';
import 'package:pixel_true_app/core/helper/date_helper.dart';

class Habit {
  final String id;
  final String name;
  final List<int> frequency; // [0,1,2,3,4,5] = Sun-Sat (DateTime.weekday)
  final List<String> reminders; // ["05:00 AM", "21:00 PM"]
  final Map<String, enHabitDailyStatus>
  logs; // {"2025-01-17": HabitStatus.complete}
  final enHabitStatus status;
  final DateTime createdAt;

  Habit({
    required this.id,
    required this.name,
    required this.frequency,
    required this.reminders,
    required this.logs,
    this.status = enHabitStatus.inProgress,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  /// 1–10 score calculated from consistency in the last 30 days
  int get easinessScore {
    final today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    int scheduled = 0;
    double completed = 0;

    for (int i = 0; i < 30; i++) {
      final day = today.subtract(Duration(days: i));
      if (!isScheduledOn(day)) continue;

      scheduled++;
      final status = logs[dateKey(day)];
      if (status == enHabitDailyStatus.complete) {
        completed += 1.0;
      } else if (status == enHabitDailyStatus.partial) {
        completed += 0.5;
      }
    }

    if (scheduled == 0) return 0;
    return ((completed / scheduled) * 9 + 1).round().clamp(1, 10);
  }

  int get longestStreak {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // find the earliest log date to start iterating from
    if (logs.isEmpty) return 0;
    final sortedKeys = logs.keys.toList()..sort();
    DateTime cursor = DateTime.parse(sortedKeys.first);

    int longest = 0, current = 0;

    while (!cursor.isAfter(today)) {
      if (isScheduledOn(cursor)) {
        final key =
            '${cursor.year}-${cursor.month.toString().padLeft(2, '0')}-${cursor.day.toString().padLeft(2, '0')}';
        final status = logs[key] ?? enHabitDailyStatus.none;

        if (status == enHabitDailyStatus.complete ||
            status == enHabitDailyStatus.partial) {
          current++;
          if (current > longest) longest = current;
        } else {
          // missed a scheduled day → reset
          current = 0;
        }
      }
      cursor = cursor.add(const Duration(days: 1));
    }

    return longest;
  }

  int get currentStreak {
    final now = DateTime.now();
    DateTime cursor = DateTime(now.year, now.month, now.day);

    int current = 0;

    while (true) {
      if (isScheduledOn(cursor)) {
        final key =
            '${cursor.year}-${cursor.month.toString().padLeft(2, '0')}-${cursor.day.toString().padLeft(2, '0')}';
        final status = logs[key] ?? enHabitDailyStatus.none;

        if (status == enHabitDailyStatus.complete ||
            status == enHabitDailyStatus.partial) {
          current++;
        } else {
          // hit a missed scheduled day → stop
          break;
        }
      }
      cursor = cursor.subtract(const Duration(days: 1));

      // safety — don't go before the first log
      if (logs.isNotEmpty) {
        final sortedKeys = logs.keys.toList()..sort();
        if (cursor.isBefore(DateTime.parse(sortedKeys.first))) break;
      } else {
        break;
      }
    }

    return current;
  }

  double get completionRate {
    final now = DateTime.now();
    final currentMonth = now.month;
    final currentYear = now.year;

    // only scheduled days in current month up to today
    final scheduledLogs = logs.entries.where((e) {
      final day = DateTime.parse(e.key);
      return day.year == currentYear &&
          day.month == currentMonth &&
          !day.isAfter(now) &&
          isScheduledOn(day);
    });

    if (scheduledLogs.isEmpty) return 0;

    // partial counts as 0.5
    final done = scheduledLogs.fold<double>(0, (sum, e) {
      if (e.value == enHabitDailyStatus.complete) return sum + 1.0;
      if (e.value == enHabitDailyStatus.partial) return sum + 0.5;
      return sum;
    });

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
            MapEntry(date, enHabitDailyStatusParser.fromString(status)),
      ),
      status: enHabitStatusParser.fromString(json['status'] ?? 'inProgress'),
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'frequency': frequency,
    'reminders': reminders,
    'logs': logs.map((date, status) => MapEntry(date, status.name)),
    'status': status.name,
    'createdAt': Timestamp.fromDate(createdAt),
  };

  Habit copyWith({
    String? name,
    List<int>? frequency,
    List<String>? reminders,
    Map<String, enHabitDailyStatus>? logs,
    enHabitStatus? status,
    DateTime? createdAt,
  }) {
    return Habit(
      id: id,
      name: name ?? this.name,
      frequency: frequency ?? this.frequency,
      reminders: reminders ?? this.reminders,
      logs: logs ?? this.logs,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  bool isScheduledOn(DateTime date) {
    final weekday = date.weekday == 7 ? 0 : date.weekday; // Sun=7 → 0
    return frequency.contains(weekday);
  }
}

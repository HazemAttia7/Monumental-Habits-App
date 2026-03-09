import 'package:flutter/material.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';

class HabitAnalysisController extends ChangeNotifier {
  DateTime _currentDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    1,
  );

  DateTime get currentDate => _currentDate;

  void onNextTap() {
    _currentDate = DateTime(_currentDate.year, _currentDate.month + 1, 1);
    notifyListeners();
  }

  void onBackTap() {
    _currentDate = DateTime(_currentDate.year, _currentDate.month - 1, 1);
    notifyListeners();
  }

  int get startOffset {
    final firstDay = DateTime(_currentDate.year, _currentDate.month, 1);
    return firstDay.weekday == 7 ? 0 : firstDay.weekday;
  }

  int get daysInMonth =>
      DateTime(_currentDate.year, _currentDate.month + 1, 0).day;

  int get prevMonthDays =>
      DateTime(_currentDate.year, _currentDate.month, 0).day;

  int get prevMonth => _currentDate.month == 1 ? 12 : _currentDate.month - 1;

  int get prevYear =>
      _currentDate.month == 1 ? _currentDate.year - 1 : _currentDate.year;

  int get totalCells => startOffset + daysInMonth;

  int get gridSize => totalCells > 35 ? 42 : 35;

  String? validateDayTap({required Habit habit, required DateTime date}) {
    final today = DateTime.now();

    if (_currentDate.year != today.year || _currentDate.month != today.month) {
      return "You can't log a habit for a different month.";
    }

    final weekDay = date.weekday % 7;
    if (!habit.frequency.contains(weekDay)) {
      return 'This day is not in your habit schedule.';
    }

    if (date.isAfter(today)) {
      return "You can't log a habit for a future day.";
    }

    return null;
  }

  static String formatDateKey(int y, int m, int d) =>
      '$y-${m.toString().padLeft(2, '0')}-${d.toString().padLeft(2, '0')}';
}

import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/utils/constants.dart';

class AddNewHabitController extends ChangeNotifier {
  bool _isEverydaySwitched = false;
  bool _isWeekendsSwitched = false;

  List<bool> _habitFrequencyList = List.generate(7, (_) => false);
  List<bool> get habitFrequencyList => _habitFrequencyList;

  List<bool> _remindersList = List.generate(12, (_) => false);
  List<bool> get remindersList => _remindersList;

  bool get isEverydaySwitched => _isEverydaySwitched;
  bool get isWeekendsSwitched => _isWeekendsSwitched;

  void clearReminders() {
    _remindersList = List.generate(12, (_) => false);
    notifyListeners();
  }

  void Function(bool)? onDayChanged(index, value) {
    _habitFrequencyList[index] = value;
    if (!value) {
      _isEverydaySwitched = false;
    }
    if (_habitFrequencyList.every((e) => e)) {
      _isEverydaySwitched = true;
    }
    _isWeekendsSwitched = _habitFrequencyList[5] && _habitFrequencyList[6];
    notifyListeners();
    return null;
  }

  void Function(bool)? onReminderChanged(index, value) {
    _remindersList[index] = value;
    notifyListeners();
    return null;
  }

  void toggleEveryday(bool value) {
    _isEverydaySwitched = value;
    _isWeekendsSwitched = value;
    _habitFrequencyList = List.generate(7, (_) => value);
    notifyListeners();
  }

  void toggleWeekends(bool value) {
    _isWeekendsSwitched = value;
    _habitFrequencyList[5] = value;
    _habitFrequencyList[6] = value;
    notifyListeners();
  }

  String getRemindersText() {
    if (_remindersList.every((e) => !e)) return 'None';
    final int firstReminderIndex = _remindersList.indexOf(
      _remindersList.firstWhere((element) => element),
    );
    final String firstReminder = initialReminders[firstReminderIndex];
    final int remindersCount = _remindersList
        .where((element) => element)
        .length;
    final String remindersSuffix = remindersCount == 1
        ? ""
        : "+${remindersCount - 1}";
    return "$firstReminder $remindersSuffix";
  }
}

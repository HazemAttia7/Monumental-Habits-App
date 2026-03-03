import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/enums/am_pm_enums.dart';
import 'package:pixel_true_app/core/widgets/closable_snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddNewHabitController extends ChangeNotifier {
  // TODO : handle PM and Am in time order
  // TODO : limit reminders to 12 and add remove reminder ui and logic
  final TextEditingController habitNameController = TextEditingController();
  bool _isEverydaySwitched = false;
  bool _isWeekendsSwitched = false;
  enAmPm selectedPeriod = enAmPm.am;

  static const String _remindersTimeKey = 'reminders_time';

  Future<void> loadReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final String? timesJson = prefs.getString(_remindersTimeKey);

    if (timesJson != null) {
      _remindersTime = List<String>.from(jsonDecode(timesJson));
      _remindersBoolList = List.generate(
        _remindersTime.length,
        (_) => false,
        growable: true,
      );
    }

    notifyListeners();
  }

  List<String> _remindersTime = [
    '6:00 AM',
    '6:30 AM',
    '7:00 AM',
    '7:30 AM',
    '8:00 AM',
    '8:30 AM',
    '9:00 AM',
    '9:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
  ];

  List<String> get remindersTime => _remindersTime;

  final FixedExtentScrollController hoursController =
      FixedExtentScrollController();
  final FixedExtentScrollController minutesController =
      FixedExtentScrollController();

  List<bool> _habitFrequencyList = List.generate(7, (_) => false);
  List<bool> get habitFrequencyList => _habitFrequencyList;

  List<bool> _remindersBoolList = List.generate(
    12,
    (_) => false,
    growable: true,
  );
  List<bool> get remindersList => _remindersBoolList;

  bool get isEverydaySwitched => _isEverydaySwitched;
  bool get isWeekendsSwitched => _isWeekendsSwitched;

  void clearReminders() {
    if (!_remindersBoolList.contains(true)) return;
    _remindersBoolList = List.generate(
      _remindersTime.length,
      (_) => false,
      growable: true,
    );
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
    _remindersBoolList[index] = value;
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
    if (_remindersBoolList.every((e) => !e)) return 'None';
    final int firstReminderIndex = _remindersBoolList.indexOf(
      _remindersBoolList.firstWhere((element) => element),
    );
    final String firstReminder = remindersTime[firstReminderIndex];
    final int remindersCount = _remindersBoolList
        .where((element) => element)
        .length;
    final String remindersSuffix = remindersCount == 1
        ? ""
        : "+${remindersCount - 1}";
    return "$firstReminder $remindersSuffix";
  }

  Future<void> _saveReminders() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_remindersTimeKey, jsonEncode(_remindersTime));
  }

  bool isRemindersListFull(BuildContext context) {
    if (remindersTime.length >= 12) {
      buildClosableSnackBar(context);
      return true;
    }
    return false;
  }

  void addReminder(BuildContext context) {
    if (isRemindersListFull(context)) return;

    final String hour = _getHoursSelectedText();
    final String minutes = _getMinutesSelectedText();
    final time = '$hour:$minutes ${getSelectedAmPmText()}';
    if (_remindersTime.contains(time)) return;
    _insertTimeOrdered(timeToInsert: time);
    _saveReminders();
    notifyListeners();
  }

  void removeReminder(int index) {
    _remindersTime.removeAt(index);
    _remindersBoolList.removeAt(index);
    _saveReminders();
    notifyListeners();
  }

  void _insertTimeOrdered({required String timeToInsert}) {
    final insertIndex = _remindersTime.indexWhere(
      (t) => _compareTime(t) > _compareTime(timeToInsert),
    );
    if (insertIndex == -1) {
      _remindersTime.add(timeToInsert);
      _remindersBoolList.add(false);
    } else {
      _remindersTime.insert(insertIndex, timeToInsert);
      _remindersBoolList.insert(insertIndex, false);
    }
  }

  int _compareTime(String time) {
    final parts = time.split(' ');
    final timeParts = parts[0].split(':');
    int hour = int.parse(timeParts[0]);
    final int minutes = int.parse(timeParts[1]);
    final String period = parts[1];

    if (period == 'PM' && hour != 12) {
      hour += 12;
    } else if (period == 'AM' && hour == 12) {
      hour = 0;
    }

    return hour * 60 + minutes;
  }

  void toggleAmPm({required clickedPeriod}) {
    if (selectedPeriod == clickedPeriod) return;
    if (selectedPeriod == enAmPm.am) {
      selectedPeriod = enAmPm.pm;
    } else {
      selectedPeriod = enAmPm.am;
    }
    notifyListeners();
  }

  String getSelectedAmPmText() => selectedPeriod == enAmPm.am ? 'AM' : 'PM';

  String _getHoursSelectedText() {
    final index = hoursController.selectedItem;
    final value = (index % 12 + 1);
    return value.toString();
  }

  String _getMinutesSelectedText() {
    final index = minutesController.selectedItem;
    final value = index % 60;
    return value.toString().padLeft(2, '0');
  }

  @override
  void dispose() {
    habitNameController.dispose();
    hoursController.dispose();
    minutesController.dispose();
    super.dispose();
  }
}

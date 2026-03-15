import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/enums/am_pm_enums.dart';
import 'package:pixel_true_app/core/enums/habit_enums.dart';
import 'package:pixel_true_app/core/widgets/animated_snack_bar.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AddEditHabitController extends ChangeNotifier {
  final TextEditingController habitNameController = TextEditingController();
  bool _isEverydaySwitched = false;
  bool _isWeekendsSwitched = false;
  enAmPm selectedPeriod = enAmPm.am;
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;
  List<bool> _previousRemindersBoolList = [];
  bool _isNotificationOn = false;
  bool get isNotificationOn => _isNotificationOn;
  enHabitStatus _status = enHabitStatus.inProgress;
  enHabitStatus get status => _status;

  void onNotificationToggle(bool isOn) {
    _isNotificationOn = isOn;
    if (!isOn) {
      clearReminders();
    } else {
      restoreReminders();
      notifyListeners();
    }
  }

  Habit? habit;

  AddEditHabitController({this.habit}) {
    _init();
  }

  Future<void> _init() async {
    await loadReminders();

    if (habit != null) {
      _initializeForEdit();
    }

    _isInitialized = true;
    notifyListeners();
  }

  void _initializeForEdit() {
    _status = habit!.status;

    habitNameController.text = habit!.name;

    _isEverydaySwitched = habit!.frequency.length == 7;

    _isWeekendsSwitched =
        habit!.frequency.contains(6) || habit!.frequency.contains(7);

    _isNotificationOn = habit!.reminders.isNotEmpty;

    _remindersBoolList = _remindersTime.map((time) {
      final normalized = _normalizeTime(time);

      return habit!.reminders.any((r) => _normalizeTime(r) == normalized);
    }).toList();

    _habitFrequencyList = List.generate(
      7,
      (index) => habit!.frequency.contains(index),
    );

    notifyListeners();
  }

  String _normalizeTime(String time) {
    final parts = time.split(' ');
    final hm = parts[0].split(':');

    final hour = int.parse(hm[0]);
    final minute = hm[1].padLeft(2, '0');

    final formattedHour = hour.toString(); // remove leading zero

    return '$formattedHour:$minute ${parts[1]}';
  }

  static const String _remindersTimeKey = 'reminders_time';

  void changeStatus(Set<enHabitStatus> status) {
    _status = status.first;
    notifyListeners();
  }

  Habit buildNewHabit() {
    final reminders = <String>[];
    for (int i = 0; i < _remindersBoolList.length; i++) {
      if (_remindersBoolList[i]) reminders.add(_remindersTime[i]);
    }

    final frequency = <int>[];
    for (int i = 0; i < _habitFrequencyList.length; i++) {
      if (_habitFrequencyList[i]) frequency.add(i);
    }

    return Habit(
      id: const Uuid().v4(),
      name: habitNameController.text.trim(),
      frequency: frequency,
      reminders: reminders,
      logs: {},
      status: enHabitStatus.inProgress,
    );
  }

  bool validate(BuildContext context) {
    if (habitNameController.text.trim().isEmpty) {
      buildClosableSnackBar(context, message: 'Habit name is required');
      return false;
    }
    if (_habitFrequencyList.every((e) => !e)) {
      buildClosableSnackBar(context, message: 'Select at least one day');
      return false;
    }
    return true;
  }

  Habit buildUpdatedHabit() {
    final reminders = <String>[];

    for (int i = 0; i < _remindersBoolList.length; i++) {
      if (_remindersBoolList[i]) {
        reminders.add(_remindersTime[i]);
      }
    }

    final frequency = <int>[];
    for (int i = 0; i < _habitFrequencyList.length; i++) {
      if (_habitFrequencyList[i]) {
        frequency.add(i);
      }
    }

    return habit!.copyWith(
      name: habitNameController.text.trim(),
      frequency: frequency,
      reminders: reminders,
      status: _status,
    );
  }

  Future<void> loadReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final String? timesJson = prefs.getString(_remindersTimeKey);

    /// Load available reminder times
    if (timesJson != null) {
      _remindersTime = List<String>.from(jsonDecode(timesJson));
    }

    if (habit != null) {
      for (var reminder in habit!.reminders) {
        if (!_remindersTime.contains(_normalizeTime(reminder))) {
          _insertTimeOrdered(timeToInsert: _normalizeTime(reminder));
        }
      }
    }

    /// Build selection state
    _remindersBoolList = _remindersTime.map((time) {
      if (habit != null) {
        return habit!.reminders.contains(time);
      }
      return false;
    }).toList();

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
    _previousRemindersBoolList = List.from(_remindersBoolList);
    _remindersBoolList = List.generate(
      _remindersTime.length,
      (_) => false,
      growable: true,
    );
    notifyListeners();
  }

  void restoreReminders() {
    if (_previousRemindersBoolList.isEmpty) return;
    _remindersBoolList = List.from(_previousRemindersBoolList);
    _previousRemindersBoolList = [];
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

  void addReminder(BuildContext context) {
    final String hour = _getHoursSelectedText();
    final String minutes = _getMinutesSelectedText();
    final time = '$hour:$minutes ${getSelectedAmPmText()}';
    if (_remindersTime.contains(time)) return;
    _insertTimeOrdered(timeToInsert: time);
    _saveReminders();
    notifyListeners();
  }

  void removeReminder(String time) {
    final index = _remindersTime.indexOf(time);
    if (index == -1) return;
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

  void reset() {
    habitNameController.clear();
    _habitFrequencyList = List.generate(7, (_) => false);
    _isEverydaySwitched = false;
    _isWeekendsSwitched = false;
    _isNotificationOn = false;
    _previousRemindersBoolList = [];
    _remindersBoolList = List.generate(
      _remindersTime.length,
      (_) => false,
      growable: true,
    );
    _status = enHabitStatus.inProgress;
    selectedPeriod = enAmPm.am;
    notifyListeners();
  }

  @override
  void dispose() {
    habitNameController.dispose();
    hoursController.dispose();
    minutesController.dispose();
    super.dispose();
  }

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
}

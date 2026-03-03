import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/enums/am_pm_enums.dart';

class AddNewHabitController extends ChangeNotifier {
  final TextEditingController habitNameController = TextEditingController();
  bool _isEverydaySwitched = false;
  bool _isWeekendsSwitched = false;
  enAmPm selectedPeriod = enAmPm.am;

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

  List<bool> _remindersBoolList = List.generate(12, (_) => false, growable: true);
  List<bool> get remindersList => _remindersBoolList;

  bool get isEverydaySwitched => _isEverydaySwitched;
  bool get isWeekendsSwitched => _isWeekendsSwitched;

  void clearReminders() {
    _remindersBoolList = List.generate(12, (_) => false);
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

  void addReminder() {
    final time =
        '${_getHoursSelectedText()}:${_getMinutesSelectedText()} ${getSelectedAmPmText()}';
    _remindersTime.add(time);
    _remindersBoolList.add(false);
    notifyListeners();
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
    return value.toString().padLeft(2, '0');
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

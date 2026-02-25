import 'package:flutter/material.dart';

class AddNewHabitController extends ChangeNotifier {
  bool _isEverydaySwitched = false;
  bool _isWeekendsSwitched = false;

  List<bool> habitFrequencyList = List.generate(7, (_) => false);
  bool get isEverydaySwitched => _isEverydaySwitched;
  bool get isWeekendsSwitched => _isWeekendsSwitched;

  void Function(bool)? onDayChanged(index, value) {
    habitFrequencyList[index] = value;
    if (!value) {
      _isEverydaySwitched = false;
    }
    if (habitFrequencyList.every((e) => e)) {
      _isEverydaySwitched = true;
    }
    _isWeekendsSwitched = habitFrequencyList[5] && habitFrequencyList[6];
    notifyListeners();
    return null;
  }

  void toggleEveryday(bool value) {
    _isEverydaySwitched = value;
    _isWeekendsSwitched = value;
    habitFrequencyList = List.generate(7, (_) => value);
    notifyListeners();
  }

  void toggleWeekends(bool value) {
    _isWeekendsSwitched = value;
    habitFrequencyList[5] = value;
    habitFrequencyList[6] = value;
    notifyListeners();
  }


}

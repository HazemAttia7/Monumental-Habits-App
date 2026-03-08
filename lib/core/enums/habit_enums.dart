// ignore: camel_case_types
enum enHabitDailyStatus { none, partial, complete }

// ignore: camel_case_extensions
extension enHabitDailyStatusX on enHabitDailyStatus {
  enHabitDailyStatus next() {
    // It uses the current state index to get the next state by incrementing it by 1 and then taking the remainder of the division by the number of states.
    return enHabitDailyStatus.values[(index + 1) %
        enHabitDailyStatus.values.length];
  }
}

// ignore: camel_case_extensions
extension enHabitDailyStatusParser on enHabitDailyStatus {
  static enHabitDailyStatus fromString(String value) {
    return enHabitDailyStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => enHabitDailyStatus.none,
    );
  }
}

// ignore: camel_case_types
enum enHabitStatus { inProgress, completed, missed }

// ignore: camel_case_extensions
extension enHabitStatusParser on enHabitStatus {
  static enHabitStatus fromString(String value) {
    return enHabitStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => enHabitStatus.inProgress,
    );
  }
}

// ignore: camel_case_types
enum enHabitFormMode {
  create,
  edit,
}

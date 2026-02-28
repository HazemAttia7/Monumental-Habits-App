// ignore: camel_case_types
enum enHabitCompletionState { none, partial, complete }

// ignore: camel_case_extensions
extension enHabitCompletionStateX on enHabitCompletionState {
  enHabitCompletionState next() {
    // It uses the current state index to get the next state by incrementing it by 1 and then taking the remainder of the division by the number of states.
    return enHabitCompletionState.values[(index + 1) %
        enHabitCompletionState.values.length];
  }
}

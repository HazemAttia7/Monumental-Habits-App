// ignore: camel_case_types
enum enCommentsFilterBy { newest, oldest, mostLiked }

extension enCommentsFilterByX on enCommentsFilterBy {
  enCommentsFilterBy next() {
    // It uses the current state index to get the next state by incrementing it by 1 and then taking the remainder of the division by the number of states.
    return enCommentsFilterBy.values[(index + 1) %
        enCommentsFilterBy.values.length];
  }
}

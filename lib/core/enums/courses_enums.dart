// ignore: camel_case_types
enum enSortBy { popular, newest, oldest, durationShortest, durationLongest }

// ignore: camel_case_types
enum enDurationFilter { under1h, oneToThree, threeToSix, sixPlus }

// ignore: camel_case_types
enum enLessonsFilter { under10, tenToTwenty, twentyToForty, fortyPlus }

class CourseFilterState {
  final Set<enDurationFilter> durations;
  final Set<enLessonsFilter> lessons;

  const CourseFilterState({this.durations = const {}, this.lessons = const {}});

  bool get isEmpty => durations.isEmpty && lessons.isEmpty;

  CourseFilterState reset() => const CourseFilterState();
}

part of 'courses_cubit.dart';

sealed class CoursesState extends Equatable {
  const CoursesState();

  @override
  List<Object> get props => [];
}

final class CoursesInitial extends CoursesState {}

final class CoursesLoading extends CoursesState {}

final class CoursesLoaded extends CoursesState {
  final List<Course> courses;
  late final List<Course> newestCourses;
  late final List<Course> oldestCourses;
  late final List<Course> shortestCourses;
  late final List<Course> longestCourses;

  List<Course> applyFilters(CoursesFilter filter, List<Course> courses) {
    return courses.where((course) {
      final matchesDuration = switch (filter.duration) {
        enDurationFilter.under1h => course.duration.inHours < 1,
        enDurationFilter.oneToThree =>
          course.duration.inHours >= 1 && course.duration.inHours < 3,
        enDurationFilter.threeToSix =>
          course.duration.inHours >= 3 && course.duration.inHours < 6,
        enDurationFilter.sixPlus => course.duration.inHours >= 6,
        null => true,
      };

      final matchesLessons = switch (filter.lessons) {
        enLessonsFilter.under10 => course.lessons.length < 10,
        enLessonsFilter.tenToTwenty =>
          course.lessons.length >= 10 && course.lessons.length < 20,
        enLessonsFilter.twentyToForty =>
          course.lessons.length >= 20 && course.lessons.length < 40,
        enLessonsFilter.fortyPlus => course.lessons.length >= 40,
        null => true,
      };

      return matchesDuration && matchesLessons;
    }).toList();
  }

  List<Course> coursesSortBy(enSortBy sortBy) => switch (sortBy) {
    enSortBy.popular => courses,
    enSortBy.newest => newestCourses,
    enSortBy.oldest => oldestCourses,
    enSortBy.durationShortest => shortestCourses,
    enSortBy.durationLongest => longestCourses,
  };

  CoursesLoaded(this.courses) {
    newestCourses = List.from(courses)
      ..sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
    oldestCourses = List.from(courses)
      ..sort((a, b) => a.publishedAt.compareTo(b.publishedAt));
    shortestCourses = List.from(courses)
      ..sort((a, b) => a.duration.compareTo(b.duration));
    longestCourses = List.from(courses)
      ..sort((a, b) => b.duration.compareTo(a.duration));
  }
  @override
  List<Object> get props => [courses];
}

class CoursesError extends CoursesState {
  final String errMessage;
  const CoursesError(this.errMessage,);
  @override
  List<Object> get props => [errMessage];
}

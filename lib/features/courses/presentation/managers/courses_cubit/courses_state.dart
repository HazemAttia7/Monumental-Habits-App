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

  const CoursesLoaded(this.courses);
}

final class CoursesError extends CoursesState {
  final String errMessage;

  const CoursesError(this.errMessage);
}

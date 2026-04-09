import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel_true_app/core/enums/courses_enums.dart';
import 'package:pixel_true_app/core/widgets/animated_snack_bar.dart';
import 'package:pixel_true_app/features/courses/presentation/managers/courses_cubit/courses_cubit.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/courses_error_view.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/courses_loaded_view.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/courses_loading_view.dart';

// TODO : refactor this by creating a controller
class CoursesViewBody extends StatefulWidget {
  const CoursesViewBody({super.key});

  @override
  State<CoursesViewBody> createState() => _CoursesViewBodyState();
}

class _CoursesViewBodyState extends State<CoursesViewBody> {
  enSortBy selectedSort = enSortBy.popular;
  CoursesFilter selectedFilter = const CoursesFilter(
    duration: null,
    lessons: null,
  );
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoursesCubit, CoursesState>(
      listener: (context, state) {
        if (state is CoursesError) {
          buildErrorSnackBar(context, message: state.errMessage);
        }
      },
      builder: (context, state) {
        if (state is CoursesLoading) {
          return const CoursesLoadingView();
        }

        if (state is CoursesLoaded) {
          final sortedCourses = state.coursesSortBy(selectedSort);
          final finalCourses = state.applyFilters(
            selectedFilter,
            sortedCourses,
          );
          return CoursesLoadedView(
            courses: finalCourses,
            onSortBySelected: (enSortBy sortBy) {
              setState(() {
                selectedSort = sortBy;
              });
            },
            onFilterSelected: (CoursesFilter filter) {
              setState(() {
                selectedFilter = filter;
              });
            },
            initialFilter: selectedFilter,
          );
        }

        if (state is CoursesError) {
          return const CoursesErrorView();
        }

        return const SizedBox();
      },
    );
  }
}

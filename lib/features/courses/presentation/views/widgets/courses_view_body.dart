import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel_true_app/core/widgets/animated_snack_bar.dart';
import 'package:pixel_true_app/features/courses/presentation/managers/courses_cubit/courses_cubit.dart';
import 'package:pixel_true_app/features/courses/presentation/managers/courses_view_controller.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/courses_error_view.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/courses_loaded_view.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/courses_loading_view.dart';

class CoursesViewBody extends StatelessWidget {
  const CoursesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CoursesViewController>();

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
          final sortedCourses = state.coursesSortBy(controller.selectedSort);
          final finalCourses = state.applyFilters(
            controller.selectedFilter,
            sortedCourses,
          );
          return CoursesLoadedView(
            courses: finalCourses,
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

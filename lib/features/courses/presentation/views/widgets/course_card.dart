import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_router.dart';
import 'package:pixel_true_app/features/courses/data/models/course_model.dart';
import 'package:pixel_true_app/features/courses/presentation/managers/courses_view_controller.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/course_details_section.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/course_image_section.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          splashColor: AppColors.primaryColor.withValues(alpha: .1),
          highlightColor: AppColors.primaryColor.withValues(alpha: .1),
          onTap: () => GoRouter.of(
            context,
          ).push(AppRouter.kCourseDetailsView, extra: course),
          child: Column(
            children: [
              CourseImageSection(imageUrl: course.imageUrl),
              CourseDetailsSection(
                title: course.title,
                duration: course.duration,
                lessonsCount: course.lessons.length,
                onSaveTap: () => context
                    .read<CoursesViewController>()
                    .onSaveCourseTapped(context, course),
                isSaved: course.isSaved,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

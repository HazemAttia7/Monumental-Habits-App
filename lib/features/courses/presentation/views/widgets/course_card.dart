import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/courses/data/models/course_model.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/course_details_section.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/course_image_section.dart';

class CourseCard extends StatelessWidget {
  final VoidCallback onTap;
  final Course course;
  final VoidCallback onSave, onUnsave;

  const CourseCard({
    super.key,
    required this.onSave,
    required this.onUnsave,
    required this.course,
    required this.onTap,
  });

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
          onTap: onTap,
          child: Column(
            children: [
              CourseImageSection(image: course.image),
              CourseDetailsSection(
                title: course.title,
                duration: course.duration,
                lessons: course.lessons,
                onSave: onSave,
                onUnsave: onUnsave,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

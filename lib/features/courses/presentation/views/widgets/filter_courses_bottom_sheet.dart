import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/enums/courses_enums.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/core/widgets/custom_handler.dart';
import 'package:pixel_true_app/features/courses/presentation/managers/courses_view_controller.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/filter_options_section.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/sheet_header.dart';
import 'package:provider/provider.dart';

class FilterCoursesBottomSheet extends StatelessWidget {
  const FilterCoursesBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CoursesViewController>();
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Align(
            alignment: AlignmentGeometry.center,
            child: CustomHandler(),
          ),
          SheetHeader(onResetTap: controller.resetFilters),
          Gap(32.h),
          FilterOptionsSection(
            onClearDurationTap: controller.onClearDurationTap,
            onClearLessonsTap: controller.onClearLessonsTap,
            selectedDuration: controller.selectedDuration,
            selectedLessons: controller.selectedLessons,
            onDurationSelected: controller.onDurationSelected,
            onLessonsSelected: controller.onLessonsSelected,
          ),
          Gap(24.h),
          CustomButton(
            text: "Apply Filters",
            onTap: () => _apply(
              context,
              selectedDuration: controller.selectedDuration,
              selectedLessons: controller.selectedLessons,
            ),
            backColor: AppColors.secondaryColor,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }

  void _apply(
    BuildContext context, {
    required enDurationFilter? selectedDuration,
    required enLessonsFilter? selectedLessons,
  }) {
    Navigator.pop(
      context,
      CoursesFilter(duration: selectedDuration, lessons: selectedLessons),
    );
  }
}

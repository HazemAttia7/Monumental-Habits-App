import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/enums/courses_enums.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/core/widgets/custom_handler.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/filter_options_section.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/sheet_header.dart';

class FilterCoursesBottomSheet extends StatefulWidget {
  final CoursesFilter initialFilter;
  const FilterCoursesBottomSheet({super.key, required this.initialFilter});

  @override
  State<FilterCoursesBottomSheet> createState() =>
      _FilterCoursesBottomSheetState();
}

class _FilterCoursesBottomSheetState extends State<FilterCoursesBottomSheet> {
  enDurationFilter? selectedDuration;
  enLessonsFilter? selectedLessons;

  @override
  void initState() {
    super.initState();

    selectedDuration = widget.initialFilter.duration;
    selectedLessons = widget.initialFilter.lessons;
  }

  @override
  Widget build(BuildContext context) {
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
          SheetHeader(
            onResetTap: () {
              setState(() {
                selectedDuration = null;
                selectedLessons = null;
              });
            },
          ),
          Gap(32.h),
          FilterOptionsSection(
            onClearDurationTap: () {
              setState(() {
                selectedDuration = null;
              });
            },
            onClearLessonsTap: () {
              setState(() {
                selectedLessons = null;
              });
            },
            selectedDuration: selectedDuration,
            selectedLessons: selectedLessons,
            onDurationSelected: (index) {
              setState(() {
                selectedDuration = enDurationFilter.values[index];
              });
            },
            onLessonsSelected: (int index) {
              setState(() {
                selectedLessons = enLessonsFilter.values[index];
              });
            },
          ),
          Gap(24.h),
          CustomButton(
            text: "Apply Filters",
            onTap: _apply,
            backColor: AppColors.secondaryColor,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }

  void _apply() {
    Navigator.pop(
      context,
      CoursesFilter(duration: selectedDuration, lessons: selectedLessons),
    );
  }
}

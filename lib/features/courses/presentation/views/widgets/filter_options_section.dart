import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/enums/courses_enums.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/filter_category_section.dart';

class FilterOptionsSection extends StatelessWidget {
  final void Function(int) onDurationSelected, onLessonsSelected;
  final VoidCallback onClearDurationTap, onClearLessonsTap;
  const FilterOptionsSection({
    super.key,
    required this.selectedDuration,
    required this.selectedLessons,
    required this.onDurationSelected,
    required this.onLessonsSelected, required this.onClearDurationTap, required this.onClearLessonsTap,
  });

  final enDurationFilter? selectedDuration;
  final enLessonsFilter? selectedLessons;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FilterCategorySection(
          onClearTap: onClearDurationTap,
          title: 'duration',
          options: const ["Under 1 hour", "1 - 3h", "3 - 6h", "+ 6h"],
          selectedOptionIndex: selectedDuration?.index,
          onSelected: onDurationSelected,
        ),
        Gap(24.h),
        FilterCategorySection(
          onClearTap: onClearLessonsTap,
          title: 'lessons number',
          options: const ["Under 10", "10 - 20", "20 - 40", "+ 40"],
          selectedOptionIndex: selectedLessons?.index,
          onSelected: onLessonsSelected,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/enums/courses_enums.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/filter_category_section.dart';

class FilterOptionsSection extends StatelessWidget {
  final void Function(int) onDurationSelected, onLessonsSelected;
  const FilterOptionsSection({
    super.key,
    required this.selectedDuration,
    required this.selectedLessons,
    required this.onDurationSelected,
    required this.onLessonsSelected,
  });

  final enDurationFilter? selectedDuration;
  final enLessonsFilter? selectedLessons;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FilterCategorySection(
          title: 'duration',
          options: const ["Under 1 hour", "1 - 3h", "3 - 6h", "+ 6h"],
          selectedOptionIndex: selectedDuration?.index ?? 0,
          onSelected: onDurationSelected,
        ),
        Gap(24.h),
        FilterCategorySection(
          title: 'lessons number',
          options: const ["Under 10", "10 - 20", "20 - 40", "+ 40"],
          selectedOptionIndex: selectedLessons?.index ?? 0,
          onSelected: onLessonsSelected,
        ),
      ],
    );
  }
}

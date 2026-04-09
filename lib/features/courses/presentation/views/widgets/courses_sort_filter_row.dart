import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/enums/courses_enums.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/filter_button.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/enum_dropdown.dart';

class CoursesSortFilterRow extends StatelessWidget {
  final dynamic Function(enSortBy) onSortBySelected;
  final VoidCallback onFilterTap;
  const CoursesSortFilterRow({super.key, required this.onSortBySelected, required this.onFilterTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Sort By:",
          style: AppStyles.textStyle16.copyWith(fontWeight: FontWeight.w500),
        ),
        Gap(4.w),
        EnumDropdown(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          options: enSortBy.values,
          initialValue: enSortBy.popular,
          labelBuilder: (enSortBy value) => _getSortByTitle(value),
          onSelected:onSortBySelected,
          borderRadius: BorderRadius.circular(16.r),
        ),
        const Spacer(),
        FilterButton(
          onTap: onFilterTap ,
        ),
      ],
    );
  }

  String _getSortByTitle(enSortBy value) {
    return switch (value) {
      enSortBy.popular => 'Popular',
      enSortBy.newest => 'Newest',
      enSortBy.oldest => 'Oldest',
      enSortBy.durationShortest => 'Duration: Shortest',
      enSortBy.durationLongest => 'Duration: Longest',
    };
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/enums/courses_enums.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/filter_button.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/enum_dropdown.dart';

class CoursesSortFilterRow extends StatelessWidget {
  const CoursesSortFilterRow({super.key});

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
          onSelected: (value) {
            // TODO : apply sort
          },
          borderRadius: BorderRadius.circular(16.r),
        ),
        const Spacer(),
        FilterButton(
          onTap: () {
            // TODO : apply filter
          },
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/filter_badge.dart';

class FilterCategorySection extends StatefulWidget {
  final String title;
  final List<String> options;
  final void Function(int index) onSelected;
  final int? selectedOptionIndex;
  const FilterCategorySection({
    super.key,
    required this.title,
    required this.options,
    required this.onSelected,
    this.selectedOptionIndex,
  });

  @override
  State<FilterCategorySection> createState() => _FilterCategorySectionState();
}

class _FilterCategorySectionState extends State<FilterCategorySection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title.toUpperCase(),
          style: AppStyles.textStyle16.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.secondaryColor.withValues(alpha: .8),
          ),
        ),
        Gap(8.h),
        Wrap(
          runSpacing: 10.h,
          spacing: 12.w,
          children: List.generate(
            widget.options.length,
            (index) => FilterBadge(
              text: widget.options[index],
              isSelected: index == widget.selectedOptionIndex,
              onTap: () => widget.onSelected(index),
            ),
          ),
        ),
      ],
    );
  }
}

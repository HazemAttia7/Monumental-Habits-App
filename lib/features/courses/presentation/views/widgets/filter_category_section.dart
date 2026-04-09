import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/custom_clickable_text.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/filter_badge.dart';

class FilterCategorySection extends StatefulWidget {
  final String title;
  final List<String> options;
  final void Function(int index) onSelected;
  final int? selectedOptionIndex;
  final VoidCallback onClearTap;
  const FilterCategorySection({
    super.key,
    required this.title,
    required this.options,
    required this.onSelected,
    this.selectedOptionIndex,
    required this.onClearTap,
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
        _SectionHeader(widget: widget),
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

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.widget});

  final FilterCategorySection widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10.w,
      children: [
        Text(
          widget.title.toUpperCase(),
          style: AppStyles.textStyle16.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.secondaryColor.withValues(alpha: .8),
          ),
        ),
        CustomClickableText(
          fontSize: 12.sp,
          text: "Clear",
          onTap: widget.onClearTap,
        ),
      ],
    );
  }
}

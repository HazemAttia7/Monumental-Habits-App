import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class FilterDropdown<T extends Enum> extends StatefulWidget {
  final List<T> options;
  final T initialValue;
  final String Function(T) labelBuilder;
  final Function(T) onSelected;

  const FilterDropdown({
    super.key,
    required this.options,
    required this.initialValue,
    required this.labelBuilder,
    required this.onSelected,
  });

  @override
  State<FilterDropdown<T>> createState() => _FilterDropdownState<T>();
}

class _FilterDropdownState<T extends Enum> extends State<FilterDropdown<T>> {
  late T _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      onSelected: (value) {
        setState(() => _selected = value);
        widget.onSelected(value);
      },
      offset: Offset(0, 44.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      color: Colors.white,
      itemBuilder: (_) => widget.options
          .map(
            (option) => PopupMenuItem(
              value: option,
              child: Text(
                widget.labelBuilder(option),
                style: AppStyles.textStyle14,
              ),
            ),
          )
          .toList(),
      child: Container(
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.secondaryColor.withValues(alpha: .1),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.labelBuilder(_selected), style: AppStyles.textStyle14),
            Gap(12.w),
            Icon(
              FontAwesomeIcons.angleDown,
              size: 18.sp,
              shadows: [
                Shadow(
                  color: AppColors.secondaryColor.withValues(alpha: .5),
                  offset: const Offset(0, 2),
                  blurRadius: 6,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

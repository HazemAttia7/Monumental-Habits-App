import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/enums/profile_enums.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class FilterDropdown extends StatefulWidget {
  final void Function(enProfileFilterBy?)? onSelected;
  const FilterDropdown({super.key, required this.onSelected});

  @override
  State<FilterDropdown> createState() => _FilterDropdownState();
}

class _FilterDropdownState extends State<FilterDropdown> {
  enProfileFilterBy _selected = enProfileFilterBy.week;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<enProfileFilterBy>(
      onSelected: (value) {
        setState(() => _selected = value);
        widget.onSelected?.call(value);
      },
      offset: Offset(0, 44.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      color: Colors.white,
      itemBuilder: (_) => [
        PopupMenuItem(
          value: enProfileFilterBy.week,
          child: Text('This week', style: AppStyles.textStyle14),
        ),
        PopupMenuItem(
          value: enProfileFilterBy.month,
          child: Text('This month', style: AppStyles.textStyle14),
        ),
        PopupMenuItem(
          value: enProfileFilterBy.year,
          child: Text('This year', style: AppStyles.textStyle14),
        ),
      ],
      child: Container(
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.primaryColor.withValues(alpha: .1),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("This ${_selected.name}", style: AppStyles.textStyle14),
            Gap(12.w),
            Icon(
              FontAwesomeIcons.angleDown,
              size: 18.sp,
              shadows: [
                Shadow(
                  color: AppColors.primaryColor.withValues(alpha: .5),
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

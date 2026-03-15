import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/home/presentation/managers/add_edit_habit_controller.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_edit_habit_widgets/flat_scroll_picker.dart';
import 'package:provider/provider.dart';

class TimeScrollView extends StatelessWidget {
  final Color themeColor;
  const TimeScrollView({super.key, this.themeColor = AppColors.secondaryColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IgnorePointer(
          child: Center(
            child: Container(
              height: timePickerItemHeight.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: themeColor.withValues(alpha: 0.12),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 60.w,
              child: FlatScrollPicker(
                itemCount: 12,
                isHours: true,
                controller: Provider.of<AddEditHabitController>(
                  context,
                ).hoursController,
              ),
            ),
            Gap(24.w),
            Text(
              ':',
              style: AppStyles.textStyle32.copyWith(
                fontFamily: DefaultTextStyle.of(context).style.fontFamily,
              ),
            ),
            Gap(24.w),
            SizedBox(
              width: 60.w,
              child: FlatScrollPicker(
                itemCount: 60,
                controller: Provider.of<AddEditHabitController>(
                  context,
                ).minutesController,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

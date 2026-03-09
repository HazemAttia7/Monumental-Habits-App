import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/custom_divider.dart';
import 'package:pixel_true_app/features/home/presentation/managers/add_edit_habit_controller.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_edit_habit_widgets/custom_clickab;e_text.dart';
import 'package:provider/provider.dart';

class AddEditReminderHeader extends StatelessWidget {
  const AddEditReminderHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomClickableText(
                text: "Cancel",
                onTap: () {
                  GoRouter.of(context).pop();
                },
              ),
              Text("Add Reminders", style: AppStyles.textStyle18),
              CustomClickableText(
                text: "Save",
                onTap: () {
                  Provider.of<AddEditHabitController>(
                    context,
                    listen: false,
                  ).addReminder(context);
                  GoRouter.of(context).pop();
                },
              ),
            ],
          ),
        ),
        Gap(16.h),
        CustomDivider(
          color: AppColors.scaffoldColor,
          width: double.infinity,
          height: 1.sp,
          margin: 0,
        ),
      ],
    );
  }
}

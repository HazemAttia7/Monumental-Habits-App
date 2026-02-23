import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_widgets/add_new_habit_header.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_widgets/habit_frequency_widget.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_widgets/habit_name_input.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_widgets/notifications_widget.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_widgets/reminder_widget.dart';

class AddNewHabitViewBody extends StatelessWidget {
  final VoidCallback? backToHome;
  const AddNewHabitViewBody({super.key, required this.backToHome});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kPagePadding.sp),
        child: Column(
          children: [
            Gap(10.h),
            SizedBox(
              height: 44.sp,
              child: AddNewHabitHeader(backToHome: backToHome),
            ),
            Gap(24.h),
            const HabitNameInput(),
            Gap(10.h),
            const HabitFrequencyWidget(),
            Gap(10.h),
            const ReminderWidget(),
            Gap(10.h),
            const NotificationsWidget(),
          ],
        ),
      ),
    );
  }
}

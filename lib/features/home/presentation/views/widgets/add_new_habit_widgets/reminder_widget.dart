import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/home/presentation/managers/add_new_habit_controller.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_widgets/reminder_bottom_sheet.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/text_icon_widget.dart';
import 'package:provider/provider.dart';

class ReminderWidget extends StatelessWidget {
  const ReminderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Reminder",
            style: AppStyles.textStyle16.copyWith(fontWeight: FontWeight.w500),
          ),
          TextIconWidget(
            text: Provider.of<AddNewHabitController>(
              context,
            ).getRemindersText(),
            icon: FontAwesomeIcons.chevronRight,
            color: AppColors.secondaryColor,
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                elevation: 10,
                context: context,
                builder: (bottomSheetContext) {
                  return ChangeNotifierProvider.value(
                    value: context.read<AddNewHabitController>(),
                    child: const Wrap(children: [ReminderBottomSheet()]),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

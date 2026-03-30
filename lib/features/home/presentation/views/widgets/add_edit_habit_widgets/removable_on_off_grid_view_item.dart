import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/managers/add_edit_habit_view_controller.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/delete_dialog.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_edit_habit_widgets/on_off_grid_view_item.dart';
import 'package:provider/provider.dart';

class RemovableOnOffGridViewItem extends StatelessWidget {
  final bool isOn;
  final String unit;
  final Function(bool) onTap;
  final Color? themeColor;
  const RemovableOnOffGridViewItem({
    super.key,
    required this.isOn,
    required this.unit,
    required this.onTap,
    this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        highlightColor: AppColors.secondaryColor.withValues(alpha: .1),
        splashColor: AppColors.secondaryColor.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(12.r),
        onLongPress: () {
          showDialog(
            context: context,
            builder: (dialogContext) => DeleteDialog(
              itemLabel: unit,
              onDelete: () {
                final controller = context.read<AddEditHabitViewController>();
                final index = controller.remindersTime.indexOf(unit);
                controller.removeReminder(controller.remindersTime[index]);
                GoRouter.of(context).pop();
              },
              headerIcon: Icons.notifications_off_rounded,
              collectionLabel: 'reminders',
              itemType: 'reminder',
            ),
          );
        },
        child: OnOffGridViewItem(
          day: unit,
          isOn: isOn,
          onTap: onTap,
          themeColor: themeColor ?? AppColors.primaryColor,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/features/home/presentation/managers/add_edit_habit_controller.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_widgets/delete_dialog_actions.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_widgets/delete_dialog_message.dart';
import 'package:provider/provider.dart';

class DeleteDialogBody extends StatelessWidget {
  final String unit;
  const DeleteDialogBody({super.key, required this.unit});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<AddEditHabitController>();
    final index = controller.remindersTime.indexOf(unit);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        children: [
          DeleteDialogMessage(reminderTime: controller.remindersTime[index]),
          SizedBox(height: 24.h),
          DeleteDialogActions(
            onCancel: () => GoRouter.of(context).pop(),
            onDelete: () {
              controller.removeReminder(index);
              GoRouter.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

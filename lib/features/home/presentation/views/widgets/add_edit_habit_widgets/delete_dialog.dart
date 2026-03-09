import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_edit_habit_widgets/delete_dialog_body.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_edit_habit_widgets/delete_dialog_header.dart';

class DeleteDialog extends StatelessWidget {
  final String unit;
  const DeleteDialog({super.key, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withValues(alpha: .15),
              blurRadius: 30,
              spreadRadius: 5,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const DeleteDialogHeader(),
            DeleteDialogBody(unit: unit),
          ],
        ),
      ),
    );
  }
}

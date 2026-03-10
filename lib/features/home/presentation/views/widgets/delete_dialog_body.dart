import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/delete_dialog_actions.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/delete_dialog_message.dart';

class DeleteDialogBody extends StatelessWidget {
  final VoidCallback onDelete;
  final String itemLabel, collectionLabel;
  const DeleteDialogBody({
    super.key,
    required this.onDelete,
    required this.itemLabel,
    required this.collectionLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        children: [
          DeleteDialogMessage(
            itemLabel: itemLabel,
            collectionLabel: collectionLabel,
          ),
          SizedBox(height: 24.h),
          DeleteDialogActions(
            onCancel: () => GoRouter.of(context).pop(),
            onDelete: onDelete,
          ),
        ],
      ),
    );
  }
}

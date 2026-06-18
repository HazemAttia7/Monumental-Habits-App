import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/delete_dialog_body.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/delete_dialog_header.dart';

class DeleteDialog extends StatelessWidget {
  final String itemLabel, collectionLabel, itemType;
  final IconData headerIcon;
  final VoidCallback onDelete;
  final String? headerText;
  final double? headerIconSize;
  final EdgeInsets? headerIconPadding;
  final String? confirmButtonText;
  const DeleteDialog({
    super.key,
    required this.onDelete,
    required this.headerIcon,
    required this.itemLabel,
    required this.collectionLabel,
    required this.itemType,
    this.headerText,
    this.headerIconSize,
    this.headerIconPadding,
    this.confirmButtonText,
  });

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
              color: AppColors.secondaryColor.withValues(alpha: .15),
              blurRadius: 30,
              spreadRadius: 5,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DeleteDialogHeader(
              headerIcon: headerIcon,
              itemType: itemType,
              headerText: headerText,
              headerIconSize: headerIconSize,
              headerIconPadding: headerIconPadding,
            ),
            DeleteDialogBody(
              confirmButtonText: confirmButtonText,
              onDelete: onDelete,
              itemLabel: itemLabel,
              collectionLabel: collectionLabel,
            ),
          ],
        ),
      ),
    );
  }
}

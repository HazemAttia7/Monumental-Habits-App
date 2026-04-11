import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/icon_container.dart';

class UnlockConfirmationDialog extends StatelessWidget {
  final int lessonNumber, lastWatchedLesson;
  final VoidCallback onConfirm;
  final String? confirmButtonText;

  const UnlockConfirmationDialog({
    super.key,
    required this.lessonNumber,
    required this.onConfirm,
    this.confirmButtonText,
    required this.lastWatchedLesson,
  });

  bool get _notStarted => lastWatchedLesson == 0;
  bool get _allPreviousDone => lastWatchedLesson == lessonNumber - 1;

  String get _title {
    if (_notStarted) return "Haven't started yet?";
    if (_allPreviousDone) return 'Unlock lesson $lessonNumber?';
    return 'Skip ahead to lesson $lessonNumber?';
  }

  @override
  Widget build(BuildContext context) {
    final buttonTextStyle = AppStyles.textStyle14.copyWith(
      fontWeight: FontWeight.bold,
    );
    final buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.r),
    );
    final buttonPadding = EdgeInsets.symmetric(vertical: 12.h);

    return Dialog(
      child: Container(
        padding: EdgeInsets.fromLTRB(24.w, 28.h, 24.w, 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const IconContainer(
              icon: Icons.lock_outline_rounded,
              iconColor: AppColors.primaryColor,
            ),
            Gap(16.h),
            Text(
              _title,
              style: AppStyles.textStyle22.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.secondaryColor,
              ),
            ),
            Gap(10.h),
            _DialogMessage(
              lessonNumber: lessonNumber,
              lastWatchedLesson: lastWatchedLesson,
            ),
            Gap(22.h),
            const Divider(color: Color(0x1F573353), height: 1),
            Gap(16.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => GoRouter.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.secondaryColor,
                      side: BorderSide(
                        color: AppColors.secondaryColor.withValues(alpha: 0.2),
                      ),
                      shape: buttonShape,
                      padding: buttonPadding,
                    ),
                    child: Text('Cancel', style: buttonTextStyle),
                  ),
                ),
                Gap(10.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      onConfirm();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: buttonShape,
                      padding: buttonPadding,
                    ),
                    child: Text(
                      confirmButtonText ?? 'Unlock anyway',
                      style: buttonTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DialogMessage extends StatelessWidget {
  final int lessonNumber, lastWatchedLesson;

  const _DialogMessage({
    required this.lessonNumber,
    required this.lastWatchedLesson,
  });

  bool get _notStarted => lastWatchedLesson == 0;
  bool get _allPreviousDone => lastWatchedLesson == lessonNumber - 1;

  String get _skippedLabel {
    final from = lastWatchedLesson + 1;
    final to = lessonNumber - 1;
    if (from == to) return 'lesson $from';
    if (from == to - 1) return 'lessons $from and $to';
    return 'lessons $from to $to';
  }

  @override
  Widget build(BuildContext context) {
    final style = AppStyles.textStyle14.copyWith(
      color: AppColors.secondaryColor.withValues(alpha: .65),
      height: 1.6,
    );

    if (_notStarted) {
      return Text(
        "You haven't started this course yet. We recommend watching from lesson 1 for the best learning experience.",
        style: style,
      );
    }

    if (_allPreviousDone) {
      return Text(
        "You've completed all previous lessons. Are you sure you want to unlock lesson $lessonNumber?",
        style: style,
      );
    }

    return RichText(
      text: TextSpan(
        style: style,
        children: [
          const TextSpan(text: 'It looks like '),
          TextSpan(
            text: _skippedLabel,
            style: const TextStyle(
              color: AppColors.secondaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const TextSpan(
            text:
                " hasn't been watched yet. We recommend completing it in order for the best learning experience.",
          ),
        ],
      ),
    );
  }
}

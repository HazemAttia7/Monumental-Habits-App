import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/edit_delete_options.dart';
import 'package:popover/popover.dart';

class ThreeDots extends StatelessWidget {
  final VoidCallback onEditTap, onDeleteTap;
  const ThreeDots({
    super.key,
    required this.onEditTap,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: () => showPopover(
          context: context,
          bodyBuilder: (context) =>
              EitDeleteOptions(onEditTap: onEditTap, onDeleteTap: onDeleteTap),
          width: 100.w,
          height: 80.h,
          backgroundColor: Color.lerp(
            AppColors.primaryColor,
            Colors.white,
            0.1,
          )!,
          direction: PopoverDirection.bottom,
        ),
        borderRadius: BorderRadius.circular(12.r),
        splashColor: AppColors.primaryColor.withValues(alpha: .1),
        highlightColor: AppColors.primaryColor.withValues(alpha: .1),
        child: Icon(
          FontAwesomeIcons.ellipsisVertical,
          color: AppColors.secondaryColor,
          size: 16.sp,
        ),
      ),
    );
  }
}

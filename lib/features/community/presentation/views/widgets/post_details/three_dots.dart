import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/edit_delete_options.dart';
import 'package:popover/popover.dart';

class ThreeDots extends StatelessWidget {
  const ThreeDots({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: () => showPopover(
          context: context,
          bodyBuilder: (context) =>
              EitDeleteOptions(onEditTap: () {}, onDeleteTap: () {}),
          width: 150.w,
          height: 80.h,
          backgroundColor: AppColors.scaffoldColor,
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

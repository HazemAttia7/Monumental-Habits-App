import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/community/presentation/managers/replies_cubit/replies_cubit.dart';
import 'package:provider/provider.dart';

class NewRepliesBanner extends StatelessWidget {
  const NewRepliesBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primaryColor,
      borderRadius: BorderRadius.circular(20.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(20.r),
        splashColor: AppColors.secondaryColor.withValues(alpha: .1),
        highlightColor: AppColors.secondaryColor.withValues(alpha: .1),
        onTap: () => context.read<RepliesCubit>().dismissNewReplies(),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
          child: Text(
            '↓ New replies',
            style: TextStyle(color: Colors.white, fontSize: 12.sp),
          ),
        ),
      ),
    );
  }
}

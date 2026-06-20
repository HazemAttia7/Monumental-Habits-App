import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/widgets/other_user_profile/shimmer/enum_dropdown_shimmer.dart';
import 'package:pixel_true_app/core/widgets/profile_placeholder.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/name_widget.dart';
import 'package:shimmer/shimmer.dart';

class UserMetaInfoRowShimmer extends StatelessWidget {
  const UserMetaInfoRowShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade400,
            highlightColor: Colors.grey.shade100,
            child: ProfilePlaceholder(
              width: 60.w,
              height: 60.h,
              fontSize: 20.sp,
              username: "user",
            ),
          ),
          Gap(10.w),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade400,
            highlightColor: Colors.grey.shade100,
            child: const NameWidget(name: "user"),
          ),
          const Spacer(),
          const EnumDropdownShimmer(),
        ],
      ),
    );
  }
}

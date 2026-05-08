import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/likes_list/shimmer/user_card_shimmer.dart';

class UsersListShimmer extends StatelessWidget {
  const UsersListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        5,
        (index) => Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: const UserCardShimmer(),
        ),
      ),
    );
  }
}

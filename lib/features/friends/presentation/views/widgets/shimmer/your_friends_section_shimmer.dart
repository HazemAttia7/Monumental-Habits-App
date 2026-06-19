import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/section_header.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/shimmer/friends_list_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class YourFriendsSectionShimmer extends StatelessWidget {
  const YourFriendsSectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: SectionHeader(text: "YOUR FRIENDS", viewAll: () {}),
        ),
        Gap(16.h),
        const FriendsListShimmer(),
      ],
    );
  }
}

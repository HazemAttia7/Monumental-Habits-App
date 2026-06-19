import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/section_header.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/shimmer/friend_reqs_list_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class FriendRequestsSectionShimmer extends StatelessWidget {
  final String requestType;
  final int listCount;
  const FriendRequestsSectionShimmer({
    super.key,
    required this.requestType,
    this.listCount = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: SectionHeader(
            text: "${requestType.toUpperCase()} REQUESTS (-)",
            viewAll: () {},
          ),
        ),
        Gap(16.h),
         FriendReqsListShimmer(listCount : listCount , requestType : requestType),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/friend_req_card.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/section_header.dart';

class FriendRequestsSection extends StatelessWidget {
  const FriendRequestsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(text: "FRIEND REQUESTS (2)"),
        Gap(16.h),
        const FriendReqCard(),
      ],
    );
  }
}

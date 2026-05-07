import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/likes_list/user_card.dart';

class UsersList extends StatelessWidget {
  const UsersList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemBuilder: (_, __) => const UserCard(),
      separatorBuilder: (_, __) => Gap(18.h),
      itemCount: 5,
    );
  }
}

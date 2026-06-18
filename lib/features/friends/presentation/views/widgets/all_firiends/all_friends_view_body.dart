import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/widgets/default_view_header.dart';
import 'package:pixel_true_app/features/friends/presentation/managers/friends_cubit/friends_cubit.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/friends_list_.dart';

class AllFriendsViewBody extends StatelessWidget {
  const AllFriendsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 18.h),
                child: const DefaultViewHeader(title: "All Friends"),
              ),
            ),
            SliverToBoxAdapter(child: Gap(24.h)),
            BlocBuilder<FriendsCubit, FriendsState>(
              buildWhen: (p, c) => c is FriendsViewLoaded,
              builder: (context, state) {
                if (state is FriendsViewLoaded) {
                  return FriendsList(friends: state.friends, viewAll: true);
                }
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/widgets/default_view_header.dart';
import 'package:pixel_true_app/features/friends/presentation/managers/user_search_cubit/user_search_cubit.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/add_friend/search_result.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/custom_search_field.dart';

class AddFriendViewBody extends StatelessWidget {
  const AddFriendViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Gap(18.h),
                  const DefaultViewHeader(title: "Add Friend"),
                  Gap(12.h),
                  CustomSearchField(
                    onChanged: (value) =>
                        context.read<UserSearchCubit>().searchUsers(value),
                    hintText: "Search for friends by username...",
                  ),
                  Gap(12.h),
                ],
              ),
            ),
            const SearchResult(),
            SliverToBoxAdapter(child: Gap(64.h)),
          ],
        ),
      ),
    );
  }
}

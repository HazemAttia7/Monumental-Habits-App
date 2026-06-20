import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/managers/cubits/other_user_habits_cubit/other_user_habits_cubit.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/widgets/other_user_profile/other_user_profile_loaded_view.dart';
import 'package:pixel_true_app/core/widgets/other_user_profile/other_user_profile_loading_view.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/user_profile_cubit/user_profile_cubit.dart';

class OtherUserProfileViewBody extends StatelessWidget {
  const OtherUserProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra as Map<String, dynamic>?;
    final isRequest = extra?['isRequest'] as bool?;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
        child: BlocBuilder<UserProfileCubit, UserProfileState>(
          builder: (context, userState) {
            return BlocBuilder<OtherUserHabitsCubit, OtherUserHabitsState>(
              builder: (context, habitState) {
                final isLoading =
                    userState is UserProfileLoading ||
                    userState is UserProfileInitial ||
                    habitState is OtherUserHabitsLoading ||
                    habitState is OtherUserHabitsInitial;

                if (isLoading) {
                  return const OtherUserProfileLoadingView();
                }

                if (userState is UserProfileError) {
                  return Center(child: Text(userState.errMessage));
                }

                if (habitState is OtherUserHabitsError) {
                  return Center(child: Text(habitState.errMessage));
                }

                final profile = (userState as UserProfileLoaded).userProfile;

                return OtherUserProfileLoadedView(
                  profile: profile,
                  isRequest: isRequest,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

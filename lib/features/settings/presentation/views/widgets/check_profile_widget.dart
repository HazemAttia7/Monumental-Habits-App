import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/managers/cubits/habits_cubit/habits_cubit.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_router.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:provider/provider.dart';

class CheckProfileWidget extends StatelessWidget {
  const CheckProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 146.h,
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
        image: const DecorationImage(
          image: AssetImage(AssetsData.profileCheck),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Check Your Profile", style: AppStyles.textStyle20),
          const Spacer(),
          Text(
            context.read<AuthCubit>().currentUser!.email,
            style: AppStyles.textStyle14.copyWith(
              color: AppColors.secondaryColor.withValues(alpha: .5),
            ),
          ),
          const Spacer(flex: 4),
          CustomButton(
            onTap: () => GoRouter.of(
              context,
            ).push(AppRouter.kProfileView, extra: context.read<HabitsCubit>()),
            text: "View",
            width: 120.w,
            height: 40.h,
          ),
        ],
      ),
    );
  }
}

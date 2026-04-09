import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/features/courses/presentation/managers/courses_cubit/courses_cubit.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/header_container.dart';

class CoursesErrorView extends StatelessWidget {
  const CoursesErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
        child: Column(
          children: [
            Column(
              children: [
                Gap(10.h),
                const HeaderContainer(),
                Gap(24.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(21.r),
                  child: Image.asset(
                    AssetsData.coursesCard,
                    fit: BoxFit.cover,
                    height: 147.h,
                  ),
                ),
                Gap(16.h),
              ],
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Something went wrong", style: AppStyles.textStyle17),
                    Gap(12.h),
                    CustomButton(
                      width: 100.w,
                      height: 40.h,
                      text: "Retry",
                      onTap: () => context.read<CoursesCubit>().getCourses(),
                    ),
                  ],
                ),
              ),
            ),
            Gap(100.h),
          ],
        ),
      ),
    );
  }
}

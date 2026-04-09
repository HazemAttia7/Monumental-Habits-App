import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/widgets/animated_snack_bar.dart';
import 'package:pixel_true_app/features/courses/presentation/managers/courses_cubit/courses_cubit.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/courses_sliver_list.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/courses_sort_filter_row.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/sliding_header_container.dart';

class CoursesViewBody extends StatelessWidget {
  const CoursesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Gap(10.h),
                  const SlidingHeaderContainer(),
                  Gap(24.h),
                  Image.asset(AssetsData.coursesCard, fit: BoxFit.cover),
                  Gap(16.h),
                  const CoursesSortFilterRow(),
                  Gap(16.h),
                ],
              ),
            ),
            BlocConsumer<CoursesCubit, CoursesState>(
              builder: (context, state) {
                if (state is CoursesLoading) {
                  // TODO : make shimmer effect
                }

                if (state is CoursesError) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Text(
                        "Oops, something went wrong !",
                        style: AppStyles.textStyle17,
                      ),
                    ),
                  );
                }

                if (state is CoursesLoaded) {
                  return CoursesSliverList(courses: state.courses);
                }

                return const SliverToBoxAdapter(child: SizedBox());
              },
              listener: (BuildContext context, CoursesState state) {
                if (state is CoursesError) {
                  buildErrorSnackBar(context, message: state.errMessage);
                }
              },
            ),
            SliverToBoxAdapter(child: Gap(100.h)),
          ],
        ),
      ),
    );
  }
}

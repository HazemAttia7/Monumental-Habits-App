import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/enums/courses_enums.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/courses/data/models/course_model.dart';
import 'package:pixel_true_app/features/courses/presentation/managers/courses_view_controller.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/courses_sliver_list.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/courses_sort_filter_row.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/filter_courses_bottom_sheet.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/sliding_header_container.dart';
import 'package:provider/provider.dart';

class CoursesLoadedView extends StatelessWidget {
  final List<Course> courses;
  const CoursesLoadedView({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CoursesViewController>();
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPersistentHeader(
              pinned: controller.isSearchOpen,
              delegate: _StickyHeaderDelegate(
                child: SizedBox(
                  height: 64.h,
                  child: SlidingHeaderContainer(
                    key: controller.headerKey,
                    onSearchChanged: controller.onSearchChanged,
                    onTap: controller.onSearchTapped,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
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
                  CoursesSortFilterRow(
                    onSortBySelected: controller.onSortBySelected,
                    onFilterTap: () async {
                      final result = await showModalBottomSheet<CoursesFilter>(
                        context: context,
                        isScrollControlled: true,
                        builder: (_) => Wrap(
                          children: [
                            ChangeNotifierProvider<CoursesViewController>.value(
                              value: controller,
                              child: const FilterCoursesBottomSheet(),
                            ),
                          ],
                        ),
                      );

                      if (result != null) {
                        controller.onFilterSelected(result);
                      }
                    },
                  ),
                  Gap(16.h),
                ],
              ),
            ),
            CoursesSliverList(courses: controller.filteredCourses(courses)),
            SliverToBoxAdapter(child: Gap(100.h)),
          ],
        ),
      ),
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickyHeaderDelegate({required this.child});

  @override
  double get minExtent => 64.h;

  @override
  double get maxExtent => 64.h;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      color: AppColors.scaffoldColor,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant _StickyHeaderDelegate oldDelegate) {
    return true;
  }
}

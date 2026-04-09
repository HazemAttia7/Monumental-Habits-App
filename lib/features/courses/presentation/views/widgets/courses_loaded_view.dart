import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/enums/courses_enums.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/courses/data/models/course_model.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/courses_sliver_list.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/courses_sort_filter_row.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/filter_courses_bottom_sheet.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/sliding_header_container.dart';

class CoursesLoadedView extends StatefulWidget {
  final CoursesFilter initialFilter;
  final List<Course> courses;
  final void Function(enSortBy sortBy) onSortBySelected;
  final void Function(CoursesFilter filter) onFilterSelected;
  const CoursesLoadedView({
    super.key,
    required this.courses,
    required this.onSortBySelected,
    required this.onFilterSelected,
    required this.initialFilter,
  });

  @override
  State<CoursesLoadedView> createState() => _CoursesLoadedViewState();
}

class _CoursesLoadedViewState extends State<CoursesLoadedView> {
  String _qurey = '';
  bool _isSearchOpen = false;
  final GlobalKey _headerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPersistentHeader(
              pinned: _isSearchOpen,
              delegate: _StickyHeaderDelegate(
                child: SizedBox(
                  height: 64.h,
                  child: SlidingHeaderContainer(
                    key: _headerKey,
                    onSearchChanged: (value) {
                      setState(() {
                        _qurey = value;
                      });
                    },
                    onTap: (bool isSearchOpen) =>
                        setState(() => _isSearchOpen = isSearchOpen),
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
                    onSortBySelected: widget.onSortBySelected,
                    onFilterTap: () async {
                      final result = await showModalBottomSheet<CoursesFilter>(
                        context: context,
                        isScrollControlled: true,
                        builder: (_) => Wrap(
                          children: [
                            FilterCoursesBottomSheet(
                              initialFilter: widget.initialFilter,
                            ),
                          ],
                        ),
                      );

                      if (result != null) {
                        widget.onFilterSelected(result);
                      }
                    },
                  ),
                  Gap(16.h),
                ],
              ),
            ),
            CoursesSliverList(
              courses: widget.courses
                  .where(
                    (element) => element.title.toLowerCase().contains(
                      _qurey.toLowerCase(),
                    ),
                  )
                  .toList(),
            ),
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

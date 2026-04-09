import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/enums/courses_enums.dart';
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
  String qurey = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Gap(10.h),
                  SlidingHeaderContainer(
                    onSearchChanged: (String p1) {
                      setState(() {
                        qurey = p1;
                      });
                    },
                  ),
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
                      qurey.toLowerCase(),
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

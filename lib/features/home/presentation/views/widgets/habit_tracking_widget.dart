import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/utils/app_router.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_completion_list_view.dart';
import 'package:redacted/redacted.dart';

class HabitTrackingWidget extends StatelessWidget {
  final ScrollController scrollController;
  final Color color;
  final Habit habit;
  final bool isLoading;
  const HabitTrackingWidget({
    super.key,
    required this.scrollController,
    required this.color,
    required this.habit,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: () {
          GoRouter.of(context).push(
            AppRouter.kHabitAnalysis,
            extra: {"habit": habit, "themeColor": color},
          );
        },
        splashColor: color.withValues(alpha: .1),
        highlightColor: color.withValues(alpha: .1),
        child:
            Container(
              padding: EdgeInsets.only(left: 18.sp, top: 12.sp, bottom: 12.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      habit.name,
                      style: AppStyles.textStyle14.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: isLoading
                        ? _buildPlaceholderRow()
                        : HabitCompletionListView(
                            scrollController: scrollController,
                            color: color,
                            habit: habit,
                          ),
                  ),
                ],
              ),
            ).redacted(
              context: context,
              redact: isLoading,
              configuration: RedactedConfiguration(
                animationDuration: const Duration(milliseconds: 800),
              ),
            ),
      ),
    );
  }

  Widget _buildPlaceholderRow() {
    return ClipRect(
      child: SizedBox(
        height: 50.sp,
        child: OverflowBox(
          alignment: Alignment.centerLeft,
          maxWidth: double.infinity,
          child: Row(
            children: List.generate(
              7,
              (i) => Padding(
                padding: EdgeInsets.only(right: 6.sp),
                child: Container(
                  width: 50.sp,
                  height: 50.sp,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: .1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_analysis_widgets/analytics_widget.dart';

class AnalyticsDetails extends StatelessWidget {
  const AnalyticsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(20.sp),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 2.6,
            crossAxisSpacing: 30.w,
            mainAxisSpacing: 30.h,
            children: const [
              AnalyticsWidget(
                title: '20 DAYS',
                subtitle: 'Longest Streak',
                icon: FontAwesomeIcons.fireFlameCurved,
                iconColor: AppColors.morning,
              ),
              AnalyticsWidget(
                title: '0 DAYS',
                subtitle: 'Current Streak',
                icon: FontAwesomeIcons.bolt,
                iconColor: AppColors.sunset,
              ),
              AnalyticsWidget(
                title: '98 %',
                subtitle: 'Completion Ratio',
                icon: FontAwesomeIcons.chartSimple,
                iconColor: AppColors.twilight,
              ),
              AnalyticsWidget(
                title: '7',
                subtitle: 'Average Easiness Score',
                icon: FontAwesomeIcons.leaf,
                iconColor: AppColors.fog,
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: VerticalDivider(
              color: AppColors.scaffoldColor,
              width: 1.w,
              thickness: 1.sp,
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Divider(
              color: AppColors.scaffoldColor,
              height: 1.h,
              thickness: 1.sp,
            ),
          ),
        ),
      ],
    );
  }
}

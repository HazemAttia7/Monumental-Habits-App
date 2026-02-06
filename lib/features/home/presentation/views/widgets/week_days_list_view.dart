import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/week_days_list_view_item.dart';

class WeekDaysListView extends StatelessWidget {
  final void Function(int index) onDayTap;
  final ScrollController scrollController;
  const WeekDaysListView({
    super.key,
    required this.onDayTap,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      itemCount: 7,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(right: 6.sp),
        child: WeekDaysListViewItem(index: index, onTap: () => onDayTap(index)),
      ),
    );
  }
}

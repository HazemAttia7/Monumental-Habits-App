import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/constants.dart';

class FlatScrollPicker extends StatelessWidget {
  final int itemCount;
  final bool isHours;
  final FixedExtentScrollController controller;

  const FlatScrollPicker({
    super.key,
    required this.itemCount,
    this.isHours = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListWheelScrollView.useDelegate(
          controller: controller,
          itemExtent: timePickerItemHeight.h,
          physics: const FixedExtentScrollPhysics(),
          perspective: 0.005,
          diameterRatio: 4.5,
          childDelegate: ListWheelChildLoopingListDelegate(
            children: List.generate(itemCount, (index) {
              final value = isHours ? index + 1 : index;

              return Center(
                child: Text(
                  value.toString().padLeft(2, '0'),
                  style: AppStyles.textStyle32.copyWith(
                    fontSize: 32.sp,
                    fontFamily: DefaultTextStyle.of(context).style.fontFamily,
                  ),
                ),
              );
            }),
          ),
        ),

        IgnorePointer(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white.withValues(alpha: 0.7),
                  Colors.white.withValues(alpha: 0.0),
                  Colors.white.withValues(alpha: 0.0),
                  Colors.white.withValues(alpha: 0.7),
                  Colors.white,
                ],
                stops: const [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

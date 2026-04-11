import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class CountdownFromDate extends StatefulWidget {
  final DateTime endTime;

  const CountdownFromDate({super.key, required this.endTime});

  @override
  State<CountdownFromDate> createState() => _CountdownFromDateState();
}

class _CountdownFromDateState extends State<CountdownFromDate> {
  Duration remaining = Duration.zero;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    updateRemaining();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      updateRemaining();
    });
  }

  void updateRemaining() {
    final diff = widget.endTime.difference(DateTime.now());

    setState(() {
      remaining = diff.isNegative ? Duration.zero : diff;
    });

    if (diff.isNegative) {
      timer?.cancel();
    }
  }

  String format(int n) => n.toString().padLeft(2, '0');

  Widget buildBox(String text) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(text, style: AppStyles.textStyle20),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hours = format(remaining.inHours);
    final minutes = format(remaining.inMinutes % 60);
    final seconds = format(remaining.inSeconds % 60);

    return Row(
      children: [
        buildBox(hours),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text(":", style: AppStyles.textStyle20),
        ),
        buildBox(minutes),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text(":", style: AppStyles.textStyle20),
        ),
        buildBox(seconds),
      ],
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}

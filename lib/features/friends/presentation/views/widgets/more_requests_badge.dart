import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class MoreRequestsBadge extends StatelessWidget {
  final int requestsLength;
  const MoreRequestsBadge({super.key, required this.requestsLength});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Center(
        child: Text(_getRequestText(), style: AppStyles.textStyle12),
      ),
    );
  }

  String _getRequestText() {
    if (requestsLength - 2 == 1) {
      return "1 more request";
    } else {
      return "$requestsLength more requests";
    }
  }
}

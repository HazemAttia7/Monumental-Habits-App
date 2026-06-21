import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/utils/app_router.dart';
import 'package:pixel_true_app/features/about_us/presentation/views/widgets/card_header.dart';
import 'package:pixel_true_app/features/about_us/presentation/views/widgets/custom_outline_button.dart';

class GetInTouchCard extends StatelessWidget {
  const GetInTouchCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10.h,
        children: [
          const CardHeader(text: "GET IN TOUCH"),
          Row(
            spacing: 12.w,
            children: [
              Expanded(
                child: CustomOutlineButton(
                  icon: Icons.star,
                  text: "Rate APP",
                  onTap: () {
                    // TODO : rate app
                  },
                ),
              ),
              Expanded(
                child: CustomOutlineButton(
                  icon: Icons.diamond,
                  text: "Connect",
                  onTap: () => GoRouter.of(context).push(AppRouter.kConnect),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

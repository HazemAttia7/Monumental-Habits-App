import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/main/presentation/managers/main_view_controller.dart';
import 'package:provider/provider.dart';

class SideMenuCloseButton extends StatelessWidget {
  const SideMenuCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.scaffoldColor2,
          boxShadow: [
            BoxShadow(
              offset: Offset(6, 6),
              color: Color(0xffE8DECB),
              spreadRadius: 0,
              blurRadius: 12,
            ),
            BoxShadow(
              offset: Offset(-6, -6),
              color: Colors.white,
              spreadRadius: 0,
              blurRadius: 12,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () {
              Provider.of<MainViewController>(
                context,
                listen: false,
              ).closeSideMenu();
            },
            child: Padding(
              padding: EdgeInsets.all(11.sp),
              child: Icon(
                FontAwesomeIcons.xmark,
                color: AppColors.primaryColor,
                size: 22.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

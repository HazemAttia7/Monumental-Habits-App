import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/enums/main_page_enum.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/custom_bottom_nav_bar.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/custom_floating_button.dart';
import 'package:pixel_true_app/features/main/presentation/managers/main_view_controller.dart';
import 'package:pixel_true_app/features/main/presentation/views/widgets/message_popup.dart';

class MainViewBody extends StatefulWidget {
  const MainViewBody({super.key});

  @override
  State<MainViewBody> createState() => _MainViewBodyState();
}

class _MainViewBodyState extends State<MainViewBody> {
  late MainViewController controller;

  @override
  void initState() {
    controller = MainViewController();
    super.initState();
  }

  @override
  void dispose() {
    controller.disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return SafeArea(
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SvgPicture.asset(
                  AssetsData.homeBackgroundImage,
                  fit: BoxFit.cover,
                ),
              ),
              PageView(
                controller: controller.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: controller.pages,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: CustomBottomNavBar(
                  currentPage: controller.currentPage,
                  onPageSelected: controller.changePage,
                ),
              ),
              if (controller.currentPage == MainPage.home ||
                  controller.currentPage == MainPage.addHabit)
                Positioned(
                  bottom: 60.sp,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Column(
                      children: [
                        if (controller.showStartPopup &&
                            !controller
                                .isKeyboardVisible) 
                          MessagePopup(onClose: controller.closePopup),
                        Gap(10.h),
                        CustomFloatingButton(
                          onTap: controller.activateFloatingButton,
                          isActive: controller.isActive,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

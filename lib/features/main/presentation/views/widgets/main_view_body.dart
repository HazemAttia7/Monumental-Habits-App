import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/enums/main_page_enum.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/core/widgets/animated_snack_bar.dart';
import 'package:pixel_true_app/core/managers/add_edit_habit_view_controller.dart';
import 'package:pixel_true_app/core/managers/cubits/habits_cubit/habits_cubit.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/custom_bottom_nav_bar.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/custom_floating_button.dart';
import 'package:pixel_true_app/features/main/presentation/managers/main_view_controller.dart';
import 'package:pixel_true_app/features/main/presentation/views/widgets/message_popup.dart';
import 'package:provider/provider.dart';

class MainViewBody extends StatelessWidget {
  const MainViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MainViewController>();
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return SafeArea(
          top: false,
          bottom: false,
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
                  controller.currentPage == MainPage.addHabit ||
                  controller.currentPage == MainPage.community)
                Positioned(
                  bottom: 60.sp,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Column(
                      children: [
                        if (controller.showStartPopup &&
                            !controller.isKeyboardVisible)
                          MessagePopup(onClose: controller.closePopup),
                        Gap(10.h),
                        CustomFloatingButton(
                          onTap: () {
                            // handle add post and move this method on MainViewController
                            final mainController = context
                                .read<MainViewController>();

                            if (!mainController.isActive) {
                              mainController.activateFloatingButton();
                            } else {
                              final addEditController = context
                                  .read<AddEditHabitViewController>();
                              if (!addEditController.validate(context)) return;
                              final habit = addEditController.buildNewHabit();
                              context.read<HabitsCubit>().addHabit(habit);
                              buildSuccessSnackBar(
                                context,
                                message:
                                    "Habit added successfully. View/Edit from your Habits History.",
                                duration: const Duration(seconds: 5),
                              );
                              addEditController.reset();
                              mainController.backToHome();
                            }
                          },
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

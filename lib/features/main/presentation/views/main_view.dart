import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/side_menu.dart';
import 'package:pixel_true_app/features/main/presentation/managers/main_view_controller.dart';
import 'package:pixel_true_app/features/main/presentation/views/widgets/main_view_body.dart';
import 'package:provider/provider.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final sideMenuController = context
        .watch<MainViewController>()
        .sideMenuController;
    return Scaffold(
      body: AnimatedBuilder(
        animation: sideMenuController,
        builder: (context, child) {
          return Stack(
            children: [
              const MainViewBody(),
              if (sideMenuController.value > 0)
                GestureDetector(
                  onTap: () =>
                      context.read<MainViewController>().closeSideMenu(),
                  child: Container(
                    color: Colors.black.withValues(
                      alpha: sideMenuController.value * .3,
                    ),
                  ),
                ),
              Positioned(
                left: (-0.83.sw) * (1 - sideMenuController.value),
                top: 0,
                bottom: 0,
                child: IgnorePointer(
                  ignoring: sideMenuController.value == 0,
                  child: const SideMenu(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

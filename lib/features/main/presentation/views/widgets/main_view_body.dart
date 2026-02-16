import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/features/home/presentation/views/add_new_habit.dart';
import 'package:pixel_true_app/features/home/presentation/views/home_view.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/custom_bottom_nav_bar.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/custom_floating_button.dart';

class MainViewBody extends StatefulWidget {
  const MainViewBody({super.key});

  @override
  State<MainViewBody> createState() => _MainViewBodyState();
}

class _MainViewBodyState extends State<MainViewBody> {
  PageController pageController = PageController(initialPage: 0);
  bool _isActive = false;
  int _currentPage = 0; // Add this

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              const HomeView(),
              const Center(child: Text("Courses View")),
              const Center(child: Text("Community View")),
              const Center(child: Text("Settings View")),
              AddNewHabit(
                backToHome: () {
                  pageController.jumpToPage(0);
                  setState(() {
                    _currentPage = 0;
                    _isActive = false;
                  });
                },
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomBottomNavBar(
              changePage: (selectedIndex) {
                pageController.jumpToPage(selectedIndex);
                setState(() {
                  _currentPage = selectedIndex;
                  _isActive = false;
                });
              },
            ),
          ),
          if (_currentPage == 0 || _currentPage == 4)
            Positioned(
              bottom: 60.sp,
              left: 0,
              right: 0,
              child: Center(
                child: CustomFloatingButton(
                  onTap: () {
                    setState(() {
                      pageController.jumpToPage(4);
                      _isActive = true;
                    });
                  },
                  isActive: _isActive,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

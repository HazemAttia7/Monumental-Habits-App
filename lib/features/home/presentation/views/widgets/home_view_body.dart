import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/home_body_content.dart';

// TODO : loading animations
class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final List<ScrollController> habitControllers = [];
  final double dayItemWidth = 50.sp;
  final ScrollController weekDaysController = ScrollController();

  void scrollHabitsToDay(int index) {
    if (!weekDaysController.hasClients) return;
  
    final targetOffset = weekDaysController.offset;

    for (final ctrl in habitControllers) {
      if (!ctrl.hasClients) continue;

      ctrl.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  void dispose() {
    weekDaysController.dispose();
    for (final ctrl in habitControllers) {
      ctrl.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: HomeBodyContent(
        weekDaysController: weekDaysController,
        habitControllers: habitControllers,
        scrollHabitsToDay: scrollHabitsToDay,
      ),
    );
  }
}

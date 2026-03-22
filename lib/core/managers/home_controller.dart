import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  final List<ScrollController> habitControllers = [];
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
}

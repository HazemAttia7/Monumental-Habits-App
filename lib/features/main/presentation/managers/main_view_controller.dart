import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/enums/main_page_enum.dart';
import 'package:pixel_true_app/features/home/presentation/managers/add_new_habit_controller.dart';
import 'package:pixel_true_app/features/home/presentation/views/add_new_habit_view.dart';
import 'package:pixel_true_app/features/home/presentation/views/home_view.dart';
import 'package:provider/provider.dart';

class MainViewController extends ChangeNotifier with WidgetsBindingObserver {
  MainViewController() {
    WidgetsBinding.instance.addObserver(this);
  }
  final PageController pageController = PageController();

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding
        .instance
        .platformDispatcher
        .views
        .first
        .viewInsets
        .bottom;
    final isVisible = bottomInset > 0;
    if (_isKeyboardVisible != isVisible) {
      _isKeyboardVisible = isVisible;
      notifyListeners();
    }
  }

  MainPage _currentPage = MainPage.home;
  bool _isActive = false;
  bool _showStartPopup = false;
  bool _isKeyboardVisible = false;

  bool get isKeyboardVisible => _isKeyboardVisible;
  MainPage get currentPage => _currentPage;
  bool get isActive => _isActive;
  bool get showStartPopup => _showStartPopup;

  late final List<Widget> pages = [
    const HomeView(),
    const Center(child: Text("Courses View")),
    const Center(child: Text("Community View")),
    const Center(child: Text("Settings View")),
    ChangeNotifierProvider(
      create: (_) => AddNewHabitController(),
      child: AddNewHabitView(backToHome: backToHome),
    ),
  ];

  int _indexOf(MainPage page) => MainPage.values.indexOf(page);

  void changePage(MainPage page) {
    pageController.jumpToPage(_indexOf(page));
    _currentPage = page;
    _isActive = false;
    _showStartPopup = false;
    notifyListeners();
  }

  void activateFloatingButton() {
    if (!_isActive) {
      _currentPage = MainPage.home;
      _isActive = true;
      _showStartPopup = true;

      pageController.jumpToPage(_indexOf(MainPage.addHabit));
      notifyListeners();
    } else {
      // TODO: Save habit to Firebase
    }
  }

  void backToHome() {
    _currentPage = MainPage.home;
    _isActive = false;
    _showStartPopup = false;

    pageController.jumpToPage(_indexOf(MainPage.home));
    notifyListeners();
  }

  void closePopup() {
    _showStartPopup = false;
    notifyListeners();
  }

  void disposeController() {
    WidgetsBinding.instance.removeObserver(this);
    pageController.dispose();
  }
}

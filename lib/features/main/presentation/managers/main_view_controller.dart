import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/enums/main_page_enum.dart';
import 'package:pixel_true_app/features/home/presentation/views/add_new_habit_view.dart';
import 'package:pixel_true_app/features/home/presentation/views/home_view.dart';

class MainViewController extends ChangeNotifier {
  final PageController pageController = PageController();

  MainPage _currentPage = MainPage.home;
  bool _isActive = false;
  bool _showStartPopup = false;

  MainPage get currentPage => _currentPage;
  bool get isActive => _isActive;
  bool get showStartPopup => _showStartPopup;

  late final List<Widget> pages = [
    const HomeView(),
    const Center(child: Text("Courses View")),
    const Center(child: Text("Community View")),
    const Center(child: Text("Settings View")),
    AddNewHabit(backToHome: backToHome),
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
      _currentPage = MainPage.addHabit;
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
    pageController.dispose();
  }
}
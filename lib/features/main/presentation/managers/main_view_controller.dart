import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pixel_true_app/core/enums/habit_enums.dart';
import 'package:pixel_true_app/core/enums/main_page_enum.dart';
import 'package:pixel_true_app/features/home/presentation/managers/add_edit_habit_controller.dart';
import 'package:pixel_true_app/features/home/presentation/managers/home_controller.dart';
import 'package:pixel_true_app/features/home/presentation/views/add_edit_habit_view.dart';
import 'package:pixel_true_app/features/home/presentation/views/home_view.dart';
import 'package:provider/provider.dart';

class MainViewController extends ChangeNotifier with WidgetsBindingObserver {
  late AnimationController _sideMenuController;
  AnimationController get sideMenuController => _sideMenuController;
  late Animation<double> _slideAnimation;
  Animation<double> get slideAnimation => _slideAnimation;

  MainViewController() {
    WidgetsBinding.instance.addObserver(this);
    final tickerProvider = _SimpleTickerProvider();
    _sideMenuController = AnimationController(
      vsync: tickerProvider,
      duration: const Duration(milliseconds: 250),
    );
    _slideAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _sideMenuController, curve: Curves.easeInOut),
    );
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
    ChangeNotifierProvider(
      create: (_) => HomeController(),
      child: const HomeView(),
    ),
    const Center(child: Text("Courses View")),
    const Center(child: Text("Community View")),
    const Center(child: Text("Settings View")),
    ChangeNotifierProvider(
      create: (_) => AddEditHabitController(),
      child: AddEditHabitView(
        backToHome: backToHome,
        habitFormMode: enHabitFormMode.create,
      ),
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

  void openSideMenu() => _sideMenuController.forward();

  void closeSideMenu() => _sideMenuController.reverse();

  void disposeController() {
    WidgetsBinding.instance.removeObserver(this);
    pageController.dispose();
    _sideMenuController.dispose();
  }
}

class _SimpleTickerProvider extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}

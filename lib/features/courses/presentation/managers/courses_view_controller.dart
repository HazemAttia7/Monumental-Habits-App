import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/enums/courses_enums.dart';
import 'package:pixel_true_app/features/courses/data/models/course_model.dart';

class CoursesViewController extends ChangeNotifier {
  CoursesViewController() {
    _selectedDuration = _selectedFilter.duration;
    _selectedLessons = _selectedFilter.lessons;
  }

  enSortBy _selectedSort = enSortBy.popular;
  CoursesFilter _selectedFilter = const CoursesFilter(
    duration: null,
    lessons: null,
  );
  String _qurey = '';
  bool _isSearchOpen = false;
  final GlobalKey _headerKey = GlobalKey();
  enDurationFilter? _selectedDuration;
  enLessonsFilter? _selectedLessons;

  enSortBy get selectedSort => _selectedSort;
  CoursesFilter get selectedFilter => _selectedFilter;
  String get qurey => _qurey;
  bool get isSearchOpen => _isSearchOpen;
  GlobalKey get headerKey => _headerKey;
  enDurationFilter? get selectedDuration => _selectedDuration;
  enLessonsFilter? get selectedLessons => _selectedLessons;

  void onSortBySelected(enSortBy sortBy) {
    _selectedSort = sortBy;
    notifyListeners();
  }

  void onFilterSelected(CoursesFilter filter) {
    _selectedFilter = filter;
    notifyListeners();
  }

  void onSearchChanged(value) {
    _qurey = value;
    notifyListeners();
  }

  void onSearchTapped(bool isSearchOpen) {
    _isSearchOpen = isSearchOpen;
    notifyListeners();
  }

  List<Course> filteredCourses(List<Course> courses) => courses
      .where(
        (element) => element.title.toLowerCase().contains(qurey.toLowerCase()),
      )
      .toList();

  void resetFilters() {
    _selectedDuration = null;
    _selectedLessons = null;
    notifyListeners();
  }

  void onClearDurationTap() {
    _selectedDuration = null;
    notifyListeners();
  }

  void onClearLessonsTap() {
    _selectedLessons = null;
    notifyListeners();
  }

  void onDurationSelected(index) {
    _selectedDuration = enDurationFilter.values[index];
    notifyListeners();
  }

  void onLessonsSelected(int index) {
    _selectedLessons = enLessonsFilter.values[index];
    notifyListeners();
  }
}

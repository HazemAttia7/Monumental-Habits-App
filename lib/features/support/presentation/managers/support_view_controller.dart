import 'package:flutter/cupertino.dart';

class SupportViewController extends ChangeNotifier {
  final List<Map<String, String>> faqs = const [
    {
      'question': 'How do I add a new habit?',
      'answer':
          "Tap the '+' button at the bottom of the home screen. Enter your habit name, choose which days of the week to repeat it, and optionally set reminders. Tap the checkmark to save.",
    },
    {
      'question': 'What do the different colored squares mean?',
      'answer':
          'Each square represents a day. An empty square means the habit was not done, a triangle means partially completed, and a filled square means fully completed. Tap any square to cycle through these states.',
    },
    {
      'question': 'How are my streaks calculated?',
      'answer':
          'Your current streak counts consecutive days where you at least partially completed a scheduled habit. Only days where the habit is scheduled count — skipping a non-scheduled day will not break your streak.',
    },
    {
      'question': 'Does the app work without internet?',
      'answer':
          'Yes! All your habits and progress are saved locally on your device first. Your data will automatically sync to the cloud the next time you have an internet connection.',
    },
    {
      'question': 'What is the Easiness Score?',
      'answer':
          'The Easiness Score is a 1–10 rating calculated automatically from your consistency over the last 30 scheduled days. A score of 10 means you completed the habit every scheduled day, while a lower score reflects missed days.',
    },
  ];

  final List<bool> _isOpen = List.generate(5, (index) => false);

  List<bool> get isOpen => _isOpen;

  void toggleExpansion(bool isExpanded, int index) {
    _isOpen[index] = isExpanded;
    notifyListeners();
  }
}

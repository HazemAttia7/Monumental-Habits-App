import 'package:shared_preferences/shared_preferences.dart';

abstract class Prefs {
  static const String _seenOnboarding = 'seenOnboarding';

  static Future<bool> getSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_seenOnboarding) ?? false;
  }

  static Future<void> setSeenOnboarding({required bool value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_seenOnboarding, value);
  }
}

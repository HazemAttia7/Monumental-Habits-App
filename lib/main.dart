import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pixel_true_app/app.dart';
// import 'package:pixel_true_app/core/utils/prefs.dart';
import 'package:pixel_true_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    dotenv.load(),
  ]);

  // // For testing purposes
  // Prefs.setSeenOnboarding(value: false);

  runApp(const MonumentalHabits());
}

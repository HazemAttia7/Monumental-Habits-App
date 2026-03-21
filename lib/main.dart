import 'package:email_otp/email_otp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pixel_true_app/app.dart';
import 'package:pixel_true_app/core/helper/service_locator.dart';
import 'package:pixel_true_app/core/services/isar_service.dart';
import 'package:pixel_true_app/core/services/notification_service.dart';
// import 'package:pixel_true_app/core/utils/prefs.dart';
import 'package:pixel_true_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final notificationService = NotificationService();
  await Future.wait([
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    dotenv.load(),
    IsarService.getInstance(),
  ]);
  await notificationService.init();
  // // For testing purposes
  // Prefs.setSeenOnboarding(value: false);
  await setupServiceLocator(notificationService: notificationService);
  EmailOTP.config(
    appName: 'Monumental',
    otpType: OTPType.numeric,
    otpLength: 6,
    expiry: 180000,
    appEmail: 'hazemco711@gmail.com',
  );

  // Gmail SMTP configuration
  EmailOTP.setSMTP(
    host: 'smtp-relay.brevo.com',
    emailPort: EmailPort.port587,
    secureType: SecureType.tls,
    username: dotenv.env['BREVO_SMTP_LOGIN']!,
    password: dotenv.env['BREVO_SMTP_KEY']!,
  );
  runApp(const MonumentalHabits());
}

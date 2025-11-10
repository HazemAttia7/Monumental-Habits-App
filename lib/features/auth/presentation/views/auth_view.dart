import 'package:flutter/material.dart';
import 'package:pixel_true_app/features/auth/presentation/views/create_account_view.dart';
import 'package:pixel_true_app/features/auth/presentation/views/login_view.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  bool showLoginPage = true;
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showLoginPage
        ? LoginView(togglePages: togglePages)
        : CreateAccountView(togglePages: togglePages);
  }
}

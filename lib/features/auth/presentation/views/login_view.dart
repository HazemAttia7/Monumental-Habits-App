import 'package:flutter/material.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  final VoidCallback togglePages;
  const LoginView({super.key, required this.togglePages});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LoginViewBody(togglePages: togglePages));
  }
}

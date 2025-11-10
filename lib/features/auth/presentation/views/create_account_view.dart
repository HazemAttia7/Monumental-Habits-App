import 'package:flutter/material.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/create_account_view_body.dart';

class CreateAccountView extends StatelessWidget {
  final VoidCallback togglePages;
  const CreateAccountView({super.key, required this.togglePages});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: CreateAccountViewBody(togglePages:togglePages));
  }
}

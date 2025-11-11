import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/monumental_habits_icons.dart';
import 'package:pixel_true_app/core/utils/validator.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/core/widgets/custom_text_form_field.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? email, pass;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        children: [
          CustomTextFormField(
            prefixIcon: MonumentalHabitsIcons.email,
            hintText: "Email",
            iconSize: 15.sp,
            validator: Validator.validateEmail,
            onSaved: (data) {
              email = data?.trim();
            },
          ),
          Gap(8.h),
          CustomTextFormField(
            prefixIcon: MonumentalHabitsIcons.lock,
            hintText: "Password",
            isPassword: true,
            validator: Validator.validateEmpty,
            onSaved: (data) {
              pass = data;
            },
          ),
          Gap(20.h),
          CustomButton(text: "Login", onTap: login, isLoading: _isLoading),
        ],
      ),
    );
  }

  void login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      await BlocProvider.of<AuthCubit>(
        context,
      ).login(email: email!, password: pass!);
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }
}

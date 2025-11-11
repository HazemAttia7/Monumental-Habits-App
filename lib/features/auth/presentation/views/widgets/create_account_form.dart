import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/monumental_habits_icons.dart';
import 'package:pixel_true_app/core/utils/validator.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/core/widgets/custom_text_form_field.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/custom_check_box.dart';

class CreateAccountForm extends StatefulWidget {
  const CreateAccountForm({super.key});

  @override
  State<CreateAccountForm> createState() => _CreateAccountFormState();
}

class _CreateAccountFormState extends State<CreateAccountForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  bool _emailMeCheckBox = false, _isLoading = false;
  String? username, email, pass;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: _autovalidateMode,
      child: Column(
        children: [
          CustomTextFormField(
            prefixIcon: Icons.person_outline_rounded,
            hintText: "Username",
            iconSize: 25.sp,
            fillColor: Colors.white,
            validator: Validator.validateUsername,
            onSaved: (data) {
              username = data?.trim();
            },
          ),
          Gap(8.h),
          CustomTextFormField(
            prefixIcon: MonumentalHabitsIcons.email,
            hintText: "Email",
            iconSize: 15.sp,
            fillColor: Colors.white,
            validator: Validator.validateEmail,
            onSaved: (data) {
              email = data?.trim();
            },
          ),
          Gap(8.h),
          CustomTextFormField(
            prefixIcon: MonumentalHabitsIcons.lock,
            hintText: "Password",
            fillColor: Colors.white,
            isPassword: true,
            validator: Validator.validatePassword,
            onSaved: (data) {
              pass = data;
            },
          ),
          Gap(28.h),
          CustomCheckbox(
            value: _emailMeCheckBox,
            onChanged: (bool? value) {
              setState(() {
                _emailMeCheckBox = value ?? false;
              });
            },
            text: 'Email me about special pricing and more',
            checkColor: AppColors.primaryColor,
            baseColor: AppColors.secondaryColor,
            textStyle: AppStyles.textStyle16.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          Gap(28.h),
          CustomButton(
            text: "Create Account",
            onTap: createAccount,
            isLoading: _isLoading,
          ),
        ],
      ),
    );
  }

  void createAccount() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      await BlocProvider.of<AuthCubit>(context).signUp(
        context,
        username: username!,
        email: email!,
        password: pass!,
        emailMe: _emailMeCheckBox,
      );
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
  }
}

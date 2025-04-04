// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_chat_gpt/bloc/auth/auth_bloc.dart';
import 'package:my_chat_gpt/model/user_model.dart';
import 'package:my_chat_gpt/them/fonts_style.dart';

class ElevatedButtonGlobal extends StatelessWidget {
  const ElevatedButtonGlobal({
    super.key,
    required this.text,
    required this.formKey,
    this.emailController,
    this.passwordController,
  });

  final String text;
  final GlobalKey<FormState> formKey;
  final TextEditingController? emailController;
  final TextEditingController? passwordController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(250.w, 45.h),
        backgroundColor: theme.colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      onPressed: () => _onButtonPressed(context),
      child: Text(
        text,
        style: MyFonts.bodyMedium.copyWith(color: theme.colorScheme.tertiary),
      ),
    );
  }

  void _onButtonPressed(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      final user = UserModel(
        email: emailController!.text,
        password: passwordController!.text,
      );

      if (text == 'Login') {
        BlocProvider.of<AuthBloc>(context).add(SignIn(user));
      } else if (text == 'Sign Up') {
        BlocProvider.of<AuthBloc>(context).add(SignUp(user));
      }
    } else {
      print("Form is not valid!");
    }
  }
}

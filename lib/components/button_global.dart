// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ichat/bloc/auth/auth_bloc.dart';
import 'package:ichat/model/user_model.dart';
import 'package:ichat/them/fonts_style.dart';

class ElevatedButtonGlobal extends StatelessWidget {
  const ElevatedButtonGlobal(
      {super.key,
      required this.text,
      required this.formKey,
      this.emailController,
      this.passwordController,
      this.displayNameController});

  final String text;
  final GlobalKey<FormState> formKey;
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final TextEditingController? displayNameController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: ElevatedButton(
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
      ),
    );
  }

  void _onButtonPressed(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      if (text == 'Sign In') {
        final user = UserModel(
          email: emailController!.text,
          password: passwordController!.text,
        );
        BlocProvider.of<AuthBloc>(context).add(SignIn(user));
      } else if (text == 'Sign Up') {
        final user = UserModel(
            email: 'fortr.vib@gmail.com', // emailController!.text,
            password: '12345678', //passwordController!.text,
            displayName: displayNameController!.text);
        BlocProvider.of<AuthBloc>(context).add(SignUp(user));
      }
    } else {
      print("Form is not valid!");
    }
  }
}

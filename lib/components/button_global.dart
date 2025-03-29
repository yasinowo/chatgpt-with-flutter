// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_chat_gpt/bloc/auth/auth_bloc.dart';
import 'package:my_chat_gpt/util/constants.dart';
import 'package:my_chat_gpt/them/fonts_style.dart';

class ElevatedButtonGlobal extends StatelessWidget {
  const ElevatedButtonGlobal(
      {super.key,
      required this.text,
      required this.formKey,
      this.usernameController,
      this.passwordController});
  final String text;
  final GlobalKey<FormState> formKey;
  final TextEditingController? usernameController;
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
      onPressed: () {
        if (formKey.currentState?.validate() ?? false) {
          // اگر مقادیر تکست‌فیلدها درست بود، عملیات را ادامه بده
          print("Form is valid");
        } else {
          // اگر خطایی وجود داشت، پیغام‌های خطا نمایش داده می‌شود
          print("Form is not valid!");
        }
        //login button
        if (text == 'Login') {
          BlocProvider.of<AuthBloc>(context).add(AuthLoginRequestE(
            usernameController!.text,
            passwordController!.text,
          ));
        }
      },
      child: Text(
        text,
        style: MyFonts.bodyMedium.copyWith(color: theme.colorScheme.tertiary),
      ),
    );
  }
}

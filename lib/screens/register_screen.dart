import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_chat_gpt/them/fonts_style.dart';
import 'package:my_chat_gpt/components/appbar_global.dart';
import 'package:my_chat_gpt/components/button_global.dart';
import 'package:my_chat_gpt/components/textfild_global.dart';
import 'package:my_chat_gpt/components/textfildpass_global.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // اضافه کردن کلید فرم
  bool checkValue = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppbarGlobal(),
        backgroundColor: theme.colorScheme.surface,
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                right: 20.w,
                left: 20.w,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Create your account',
                      style: MyFonts.titleMedium.copyWith(
                          color: theme.colorScheme.tertiary,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: Text(
                        'Join our secure AI chat platform',
                        style: MyFonts.bodyMedium
                            .copyWith(color: theme.colorScheme.primary),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: TextFildGlobal(
                          controller: fullnameController,
                          text: 'Full Name',
                        )),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: TextFildGlobal(
                          controller: usernameController,
                          text: 'Email Address',
                        )),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: PwTextFildGlobal(
                          controller: passwordController,
                          text: 'Password',
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 10.h, bottom: 5),
                        child: PwTextFildGlobal(
                          controller: passwordConfirmController,
                          text: 'Password Confirm',
                          passwordConfirmController: passwordController,
                        )),
                    agreeTP(theme),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.w),
                      child: ElevatedButtonGlobal(
                        text: 'Sign Up',
                        formKey: _formKey,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 1.h,
                            width: 70.w,
                            child: Divider(
                              thickness: 0.9,
                              indent: 0,
                              endIndent: 7,
                              // color: Colors.white,
                            ),
                          ),
                          Text(
                            'Or continue with',
                            style: MyFonts.bodySmall
                                .copyWith(color: theme.colorScheme.primary),
                          ),
                          SizedBox(
                            height: 1.h,
                            width: 70.w,
                            child: Divider(
                              thickness: 0.9,
                              indent: 7,
                              endIndent: 0,
                              //color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 15.h),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          width: 250.w,
                          height: 45.h,
                          decoration: BoxDecoration(
                              color: theme.colorScheme.inversePrimary,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/google.png',
                                height: 25.h,
                                width: 25.w,
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Text(' Sign up with Google',
                                  style: MyFonts.bodyMedium.copyWith(
                                      color: theme.colorScheme.tertiary))
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: MyFonts.bodySmall
                              .copyWith(color: theme.colorScheme.primary),
                        ),
                        Text(
                          'Login',
                          style: MyFonts.bodySmall
                              .copyWith(color: theme.colorScheme.tertiary),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }

  agreeTP(ThemeData theme) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Checkbox(
        activeColor: theme.colorScheme.primary,
        value: checkValue,
        onChanged: (value) {
          setState(() {
            checkValue = !checkValue;
          });
        },
      ),
      Text(
        'I agree to the ',
        style: MyFonts.bodySmall.copyWith(color: theme.colorScheme.tertiary),
      ),
      Text(
        'Terms',
        style: MyFonts.bodySmall.copyWith(color: theme.colorScheme.primary),
      ),
      Text(
        ' and ',
        style: MyFonts.bodySmall.copyWith(color: theme.colorScheme.tertiary),
      ),
      Text(
        'Privacy Policy',
        style: MyFonts.bodySmall.copyWith(color: theme.colorScheme.primary),
      ),
    ]);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_chat_gpt/data/bloc/auth/auth_bloc.dart';
import 'package:my_chat_gpt/data/bloc/massege/massage_bloc.dart';
import 'package:my_chat_gpt/data/model/massage.dart';
import 'package:my_chat_gpt/screens/chat_screen.dart';
import 'package:my_chat_gpt/util/auth_manager.dart';
import 'package:my_chat_gpt/util/constants.dart';
import 'package:my_chat_gpt/widget/global/button_global.dart';
import 'package:my_chat_gpt/widget/global/textfild_global.dart';
import 'package:my_chat_gpt/widget/global/textfildpass_global.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // اضافه کردن کلید فرم

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthResponseS) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                    create: (context) => MassageBloc(),
                    child: const ChatScreen()),
              ),
            );
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 100.h),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Ai Chat',
                      style: theme.textTheme.titleLarge!
                          .copyWith(color: AppColor.white),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h, bottom: 10.h),
                      child: Text(
                        'Welcome back! Please login to continue',
                        style: theme.textTheme.bodySmall!
                            .copyWith(color: AppColor.txgrey),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: TextFildGlobal(
                          controller: usernameController,
                          text: 'Email Address',
                        )),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: TextFildPasswordGlobal(
                          controller: passwordController,
                          text: 'Password',
                        )),
                    Padding(
                      padding: EdgeInsets.only(left: 150.w),
                      child: Text(
                        'Forgot password?',
                        style: theme.textTheme.bodySmall!
                            .copyWith(color: AppColor.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.w),
                      child: ElevatedButtonGlobal(
                        text: 'Login',
                        formKey: _formKey,
                        usernameController: usernameController,
                        passwordController: passwordController,
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
                              //color: Colors.white,
                            ),
                          ),
                          Text(
                            'Or continue with',
                            style: theme.textTheme.bodySmall!
                                .copyWith(color: AppColor.txgrey),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              AuthManager.logout();
                            },
                            child: Container(
                              width: 120.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                  color: AppColor.normal,
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
                                  Text('Google',
                                      style: theme.textTheme.bodyMedium!
                                          .copyWith(color: AppColor.white))
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 120.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                  color: AppColor.normal,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.apple,
                                      color: AppColor.white, size: 38),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  Text(
                                    'apple',
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: AppColor.white),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Dont have an account? ',
                          style: theme.textTheme.bodySmall!
                              .copyWith(color: AppColor.txgrey),
                        ),
                        Text(
                          'Sign up',
                          style: theme.textTheme.bodySmall!
                              .copyWith(color: AppColor.white),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Contact to us? ',
                          style: theme.textTheme.bodySmall!
                              .copyWith(color: AppColor.txgrey),
                        ),
                        InkWell(
                          onTap: () {
                            Uri uri = Uri.parse('https://t.me/yasinid');
                            launchUrl(uri,
                                mode: LaunchMode.externalApplication);
                          },
                          child: Text(
                            'yasinid',
                            style: theme.textTheme.bodySmall!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

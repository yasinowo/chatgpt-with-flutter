import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_chat_gpt/util/constants.dart';
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
        appBar: appBarGlobal(theme, context),
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Create your account',
                      style: theme.textTheme.titleMedium!.copyWith(
                          color: AppColor.white, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h, bottom: 10.h),
                      child: Text(
                        'Join our secure AI chat platform',
                        style: theme.textTheme.bodyMedium!
                            .copyWith(color: AppColor.txgrey),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: MyTextFild(
                          controller: fullnameController,
                          text: 'Full Name',
                        )),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: MyTextFild(
                          controller: usernameController,
                          text: 'Email Address',
                        )),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: MypassTextFild(
                          controller: passwordController,
                          text: 'Password',
                        )),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: MypassTextFild(
                          controller: passwordConfirmController,
                          text: 'Password Confirm',
                          passwordConfirmController: passwordController,
                        )),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.w),
                      child: agreeTP(theme),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.w),
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
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          width: 250.w,
                          height: 45.h,
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
                              Text(' Sign up with Google',
                                  style: theme.textTheme.bodyMedium!
                                      .copyWith(color: AppColor.white))
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
                          style: theme.textTheme.bodySmall!
                              .copyWith(color: AppColor.txgrey),
                        ),
                        Text(
                          'Login',
                          style: theme.textTheme.bodySmall!
                              .copyWith(color: AppColor.white),
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
        activeColor: AppColor.strong,
        value: checkValue,
        onChanged: (value) {
          setState(() {
            checkValue = !checkValue;
          });
        },
      ),
      Text(
        'I agree to the ',
        style: theme.textTheme.bodySmall!.copyWith(color: AppColor.white),
      ),
      Text(
        'Terms',
        style: theme.textTheme.bodySmall!.copyWith(color: AppColor.txgrey),
      ),
      Text(
        ' and ',
        style: theme.textTheme.bodySmall!.copyWith(color: AppColor.white),
      ),
      Text(
        'Privacy Policy',
        style: theme.textTheme.bodySmall!.copyWith(color: AppColor.txgrey),
      ),
    ]);
  }
}

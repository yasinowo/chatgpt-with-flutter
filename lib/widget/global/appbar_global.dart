import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_chat_gpt/data/bloc/auth/auth_bloc.dart';
import 'package:my_chat_gpt/screens/login_screen.dart';
import 'package:my_chat_gpt/util/auth_manager.dart';
import 'package:my_chat_gpt/util/constants.dart';

PreferredSize appBarGlobal(dynamic theme, BuildContext context) {
  return PreferredSize(
    preferredSize: Size(100.w, 50.h),
    child: Padding(
      padding: EdgeInsets.only(
        right: 20.w,
        left: 20.w,
        top: 10.h,
      ),
      child: Row(
        children: [
          Text(
            'AI Assistant',
            style: theme.textTheme.titleSmall!.copyWith(color: AppColor.white),
          ),
          Spacer(),
          // استفاده از PopupMenuButton به جای GestureDetector
          PopupMenuButton<String>(
            color: AppColor.hover,
            icon: CircleAvatar(
              backgroundColor: AppColor.normal,
              child: Icon(Icons.person, color: AppColor.white),
            ),
            onSelected: (value) {
              if (value == 'logout') {
                AuthManager.logout();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => AuthBloc(),
                      child: const LoginScreen(),
                    ),
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'logout',
                  child: Text(
                    'خروج از حساب',
                    textAlign: TextAlign.right,
                    style: theme.textTheme.bodySmall.copyWith(
                      color: AppColor.white,
                    ),
                  ),
                ),
                // می‌تونید گزینه‌های بیشتری اضافه کنید
                // PopupMenuItem<String>(
                //   value: 'settings',
                //   child: Text('تنظیمات'),
                // ),
              ];
            },
          ),
        ],
      ),
    ),
  );
}

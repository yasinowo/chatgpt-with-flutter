import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_chat_gpt/bloc/auth/auth_bloc.dart';
import 'package:my_chat_gpt/screens/login_screen.dart';
import 'package:my_chat_gpt/them/fonts_style.dart';
import 'package:my_chat_gpt/util/auth_manager.dart';

class AppbarGlobal extends StatelessWidget implements PreferredSizeWidget {
  const AppbarGlobal({super.key});

  @override
  Size get preferredSize => Size(100.w, 50.h); // اندازه ترجیحی را مشخص کنید

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(
        right: 5.w,
        left: 5.w,
        top: 10.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Icon(
              Icons.menu,
              color: theme.colorScheme.tertiary,
              size: 25.sp,
            ),
          ),

          Text(
            'AI Assistant',
            style:
                MyFonts.titleSmall.copyWith(color: theme.colorScheme.tertiary),
          ),
          SizedBox(
            width: 25.w,
          )
          // const Spacer(),
          // popupMenu(theme, context),
        ],
      ),
    );
  }

  PopupMenuButton<String> popupMenu(ThemeData theme, BuildContext context) {
    return PopupMenuButton<String>(
      color: theme.colorScheme.surface,
      icon: CircleAvatar(
        backgroundColor: theme.colorScheme.inversePrimary,
        child: Icon(Icons.person, color: theme.colorScheme.tertiary),
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
              style: MyFonts.bodySmall.copyWith(
                color: theme.colorScheme.tertiary,
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
    );
  }

  Widget get child => throw UnimplementedError();
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_chat_gpt/bloc/auth/auth_bloc.dart';
import 'package:my_chat_gpt/screens/login_screen.dart';
import 'package:my_chat_gpt/them/fonts_style.dart';
import 'package:my_chat_gpt/util/auth_manager.dart';

class DrawerGlobal extends StatelessWidget {
  const DrawerGlobal({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(
        dividerTheme: DividerThemeData(
          color: theme.colorScheme.primary,
          thickness: 2,
        ),
      ),
      child: Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
              ),
              child: Center(
                child: Text(
                  'AI Chat',
                  style: MyFonts.titleLarge
                      .copyWith(color: theme.colorScheme.tertiary),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: ListTile(
                leading: Icon(Icons.message,
                    size: 28.sp, color: theme.colorScheme.tertiary),
                title: Text(
                  'Messages',
                  style: MyFonts.bodyLarge
                      .copyWith(color: theme.colorScheme.tertiary),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Handle item tap
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: ListTile(
                leading: Icon(Icons.account_circle,
                    size: 28.sp, color: theme.colorScheme.tertiary),
                title: Text('Profile',
                    style: MyFonts.bodyLarge
                        .copyWith(color: theme.colorScheme.tertiary)),
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: ListTile(
                leading: Icon(Icons.settings,
                    size: 28.sp, color: theme.colorScheme.tertiary),
                title: Text('Settings',
                    style: MyFonts.bodyLarge
                        .copyWith(color: theme.colorScheme.tertiary)),
                onTap: () {
                  Navigator.pushNamed(context, '/setting');
                },
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: ListTile(
                leading: Icon(Icons.logout_sharp,
                    size: 28.sp, color: theme.colorScheme.tertiary),
                title: Text('Logout',
                    style: MyFonts.bodyLarge
                        .copyWith(color: theme.colorScheme.tertiary)),
                onTap: () {
                  AuthManager.logout();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => AuthBloc(),
                        child: const LoginScreen(),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 15.w)
          ],
        ),
      ),
    );
  }
}

// This code is licensed under the CC BY-NC-ND 4.0 License.
// See the LICENSE file for details.   <<<<<<<<<<<====================================
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_chat_gpt/bloc/auth/auth_bloc.dart';
import 'package:my_chat_gpt/bloc/massege/massage_bloc.dart';
import 'package:my_chat_gpt/data/database/chat_database.dart';
import 'package:my_chat_gpt/data/di.dart';
import 'package:my_chat_gpt/screens/chat_screen.dart';
import 'package:my_chat_gpt/screens/login_screen.dart';
import 'package:my_chat_gpt/screens/register_screen.dart';
import 'package:my_chat_gpt/them/dark_mode.dart';
import 'package:my_chat_gpt/them/theme.dart';
import 'package:my_chat_gpt/util/auth_manager.dart';
import 'package:sqflite/sqflite.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getItInit();
  runApp(const MyApp());
  ChatDatabase.instance.database;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // themeMode: ThemeMode.dark,
          theme: darkMode,
          // AppThem().themData,

          // You can use the library anywhere in the app even in theme
          home: child,
        );
      },
      child: (AuthManager.hasUsername() == false)
          ? BlocProvider(
              create: (context) => AuthBloc(),
              child: LoginScreen(),
            )
          : BlocProvider(
              create: (context) => MassageBloc(),
              child: ChatScreen(),
            ),
    );
  }
}

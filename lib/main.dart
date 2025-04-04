// This code is licensed under the CC BY-NC-ND 4.0 License.
// See the LICENSE file for details.   <<<<<<<<<<<====================================
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_chat_gpt/bloc/auth/auth_bloc.dart';
import 'package:my_chat_gpt/bloc/massege/massage_bloc.dart';
import 'package:my_chat_gpt/data/database/chat_database.dart';
import 'package:my_chat_gpt/data/di.dart';
import 'package:my_chat_gpt/data/shared_prefernce.dart';
import 'package:my_chat_gpt/screens/chat_screen.dart';
import 'package:my_chat_gpt/screens/login_screen.dart';
import 'package:my_chat_gpt/screens/profile_screen.dart';
import 'package:my_chat_gpt/screens/register_screen.dart';
import 'package:my_chat_gpt/screens/setting_screen.dart';
import 'package:my_chat_gpt/them/theme_provider.dart';
import 'package:my_chat_gpt/util/auth_manager.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getItInit();
  await Supabase.initialize(
    url: 'https://qlqpcmtolqfuekyobqae.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFscXBjbXRvbHFmdWVreW9icWFlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDM3NjczMzAsImV4cCI6MjA1OTM0MzMzMH0.Bw2Z1o-S_DaWML6XXNgH2sU9BvbD5ayqs5g7N7l3KIo',
  );
  runApp(ChangeNotifierProvider(
    child: const MyApp(),
    create: (context) => ThemeProvider(context),
  ));
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
          theme: Provider.of<ThemeProvider>(context).themeData,
          // AppThem().themData,
          routes: {
            '/register': (context) => const RegisterScreen(),
            '/login': (context) => const LoginScreen(),
            '/chat': (context) => const ChatScreen(),
            '/setting': (context) => const SettingScreen(),
            '/profile': (context) => const ProfileScreen(),
          },
          // You can use the library anywhere in the app even in theme
          home: child,
        );
      },
      child: FutureBuilder(
        future: checkToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.data == true) {
            return ChatScreen();
          } else {
            return LoginScreen();
          }
        },
      ),

      //  (AuthManager.hasUsername() == false)
      //     ? BlocProvider(
      //         create: (context) => AuthBloc(),
      //         child: LoginScreen(),
      //       )
      //     : BlocProvider(
      //         create: (context) => MassageBloc(),
      //         child: ChatScreen(),
      //       ),
    );
  }
}

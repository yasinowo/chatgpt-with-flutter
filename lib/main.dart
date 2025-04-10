// This code is licensed under the CC BY-NC-ND 4.0 License.
// See the LICENSE file for details.   <<<<<<<<<<<====================================
//c582444fcf59d197a0bc15bbf8d5961ebfb19f91d7cdf4bc1254a1fcd2c45758 virussh
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ichat/bloc/massege/massage_bloc.dart';
import 'package:ichat/data/database/chat_database.dart';
import 'package:ichat/data/di.dart';
import 'package:ichat/data/shared_prefernce.dart';
import 'package:ichat/screens/chat_screen.dart';
import 'package:ichat/screens/edit_profile_screen.dart';
import 'package:ichat/screens/login_screen.dart';
import 'package:ichat/screens/profile_screen.dart';
import 'package:ichat/screens/register_screen.dart';
import 'package:ichat/screens/setting_screen.dart';
import 'package:ichat/them/theme_provider.dart';
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
            '/chat': (context) => BlocProvider(
                create: (context) => MessegeBloc(), child: const ChatScreen()),
            '/setting': (context) => const SettingScreen(),
            '/profile': (context) => const ProfileScreen(),
            '/edit_profile': (context) => const EditProfileScreen(),
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
            return BlocProvider(
                create: (context) => MessegeBloc(), child: ChatScreen());
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_chat_gpt/them/dark_mode.dart';
import 'package:my_chat_gpt/them/light_mod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = darkMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  ThemeProvider(BuildContext context) {
    _loadTheme(context); // بارگیری تم ذخیره شده یا تنظیم بر اساس روشنایی سیستم
  }

  Future<void> _loadTheme(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDarkMode');
    if (isDark == null) {
      // تم ذخیره شده وجود ندارد، بر اساس روشنایی سیستم تنظیم کنید
      final brightness = MediaQuery.platformBrightnessOf(context);
      _themeData = brightness == Brightness.dark ? darkMode : lightMode;
      _saveTheme(brightness == Brightness.dark);
    } else {
      // تم ذخیره شده وجود دارد، از آن استفاده کنید
      _themeData = isDark ? darkMode : lightMode;
    }
    notifyListeners();
  }

  Future<void> _saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDark);
  }

  void toggleTheme() {
    _themeData = _themeData == lightMode ? darkMode : lightMode;
    _saveTheme(isDarkMode);
    notifyListeners();
  }
}

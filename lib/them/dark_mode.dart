import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
      surface: Color(0xff111827), // پس‌زمینه
      // primary: Color(0xff111827), // متن‌های فرعی و راهنما
      secondary: Color(0xff374151), // رنگ‌های فعال
      tertiary: Color(0xffffffff), // متن‌های روشن
      inversePrimary: Color(0xff1F2937), // متن‌های معمولی و دکمه‌های غیرفعال
      primary: Color(0xff6B7280), // متن‌های قوی‌تر
      shadow: Color(0xff030712), // سایه‌ها
      primaryContainer: Colors.black),
);

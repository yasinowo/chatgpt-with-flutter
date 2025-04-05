import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    surface: Colors.white, // پس‌زمینه (در دارک مود: 0xff111827)
    secondary: Color(0xffE0E0E0), // رنگ‌های فعال (در دارک مود: 0xff374151)
    tertiary: Colors.black, // متن‌های روشن (در دارک مود: 0xffffffff)
    inversePrimary: Color(
        0xffF0F0F0), // متن‌های معمولی و دکمه‌های غیرفعال (در دارک مود: 0xff1F2937)
    primary: Color(0xff616161), // متن‌های قوی‌تر (در دارک مود: 0xff6B7280)
    shadow: Color(0xffD1D5DB), // سایه‌ها (در دارک مود: 0xff030712)
    primaryContainer: Colors.lightBlueAccent, // رنگ اصلی دکمه ها
  ),
);

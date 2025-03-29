import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_chat_gpt/util/constants.dart';
import 'package:my_chat_gpt/them/fonts_style.dart';

class AppThem {
  final ThemeData themData = ThemeData(
      brightness: Brightness.dark,
      textTheme: _textTheme,
      scaffoldBackgroundColor: AppColor.hover,
      elevatedButtonTheme: _elevatedButtonThemeData);
}

TextTheme _textTheme = TextTheme(
    titleLarge: MyFonts.titleLarge,
    titleMedium: MyFonts.titleMedium,
    titleSmall: MyFonts.titleSmall,
    bodySmall: MyFonts.bodySmall,
    bodyMedium: MyFonts.bodyMedium,
    bodyLarge: MyFonts.bodyLarge,
    displaySmall: MyFonts.displaySmall

    //
    );
ElevatedButtonThemeData _elevatedButtonThemeData = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    minimumSize: Size(250.w, 45.h),
    backgroundColor: AppColor.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  ),
);

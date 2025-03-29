import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_chat_gpt/util/constants.dart';
import 'package:my_chat_gpt/util/fonts.dart';

class AppThem {
  final ThemeData themData = ThemeData(
      brightness: Brightness.dark,
      textTheme: _textTheme,
      scaffoldBackgroundColor: AppColor.hover,
      elevatedButtonTheme: _elevatedButtonThemeData);
}

TextTheme _textTheme = TextTheme(
    titleLarge: Fonts.titleLarge,
    titleMedium: Fonts.titleMedium,
    titleSmall: Fonts.titleSmall,
    bodySmall: Fonts.bodySmall,
    bodyMedium: Fonts.bodyMedium,
    bodyLarge: Fonts.bodyLarge,
    displaySmall: Fonts.displaySmall

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

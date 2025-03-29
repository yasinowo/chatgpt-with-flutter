import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_chat_gpt/them/fonts_style.dart';
import 'package:my_chat_gpt/util/constants.dart';

// ignore: must_be_immutable
class MyTextFild extends StatelessWidget {
  MyTextFild({super.key, required this.controller, required this.text});
  TextEditingController controller = TextEditingController();
  String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 275.w,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: controller,
        style: MyFonts.bodyLarge.copyWith(color: theme.colorScheme.primary),
        decoration: InputDecoration(
          fillColor: AppColor.normal,
          filled: true,
          labelText: text,
          labelStyle:
              MyFonts.bodyMedium.copyWith(color: theme.colorScheme.primary),
          prefixIcon: Padding(
            padding: EdgeInsets.only(right: 10.w, left: 15.w),
            child: Icon(
              Icons.email_outlined,
              size: 32,
              color: theme.colorScheme.primary,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(color: theme.colorScheme.secondary, width: 4),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(color: theme.colorScheme.secondary, width: 3)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            if (text == "Email Address") {
              return "Please enter eamil";
            } else if (text == "Full Name") {
              return "Please enter name";
            }
            return "Please fiil this fild";
          }
          return null;
        },
      ),
    );
  }
}

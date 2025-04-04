// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_chat_gpt/them/fonts_style.dart';
import 'package:my_chat_gpt/util/constants.dart';

class PwTextFildGlobal extends StatefulWidget {
  PwTextFildGlobal(
      {super.key,
      required this.controller,
      required this.text,
      this.passwordConfirmController});
  TextEditingController controller = TextEditingController();
  TextEditingController? passwordConfirmController = TextEditingController();
  String text;
  @override
  State<PwTextFildGlobal> createState() => _PwTextFildGlobalState();
}

class _PwTextFildGlobalState extends State<PwTextFildGlobal> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 275.w,
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscurePassword,
        style: MyFonts.bodyLarge.copyWith(color: theme.colorScheme.primary),
        decoration: InputDecoration(
          fillColor: theme
              .colorScheme.inversePrimary, // Change this to your desired color
          filled: true,
          labelText: widget.text,
          labelStyle:
              MyFonts.bodyMedium.copyWith(color: theme.colorScheme.primary),

          prefixIcon: Padding(
            padding: EdgeInsets.only(right: 10.w, left: 15.w),
            child: Icon(
              Icons.password_outlined,
              size: 26.sp,
              color: theme.colorScheme.primary,
            ),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
            icon: _obscurePassword
                ? Icon(
                    Icons.visibility_off_outlined,
                    color: theme.colorScheme.primary,
                  )
                : Icon(
                    Icons.visibility_outlined,
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
                  BorderSide(color: theme.colorScheme.primary, width: 3)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            if (widget.text == 'Password') {
              return "Please enter password";
            } else if (widget.text == 'Password Confirm') {
              if (value != widget.passwordConfirmController!.text) {
                return "Passwords do not match.";
              }
              return "Please enter password confirm";
            }
            return "Please fill this flid.";
          } else if (value.length < 8) {
            return "Password must be at least 8 characters";
          } else if (widget.text == 'Password Confirm' &&
              value != widget.passwordConfirmController!.text) {
            return "Passwords do not match.";
          }

          return null;
        },
      ),
    );
  }
}

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_chat_gpt/util/constants.dart';

class TextFildPasswordGlobal extends StatefulWidget {
  TextFildPasswordGlobal(
      {super.key,
      required this.controller,
      required this.text,
      this.passwordConfirmController});
  TextEditingController controller = TextEditingController();
  TextEditingController? passwordConfirmController = TextEditingController();
  String text;
  @override
  State<TextFildPasswordGlobal> createState() => _TextFildPasswordGlobalState();
}

class _TextFildPasswordGlobalState extends State<TextFildPasswordGlobal> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 275.w,
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscurePassword,
        style: theme.textTheme.bodyLarge!.copyWith(color: AppColor.txgrey),
        decoration: InputDecoration(
          fillColor: AppColor.normal, // Change this to your desired color
          filled: true,
          labelText: widget.text,
          labelStyle:
              theme.textTheme.bodyMedium!.copyWith(color: AppColor.strong),

          prefixIcon: Padding(
            padding: EdgeInsets.only(right: 10.w, left: 15.w),
            child: const Icon(
              Icons.password_outlined,
              size: 32,
              color: AppColor.strong,
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
                    color: AppColor.strong,
                  )
                : Icon(
                    Icons.visibility_outlined,
                    color: AppColor.strong,
                  ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColor.active, width: 4),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColor.strong, width: 3)),
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

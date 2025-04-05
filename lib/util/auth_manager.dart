// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:ichat/data/di.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static final ValueNotifier<String?> authNotifier = ValueNotifier(null);
  static final SharedPreferences sharedPreferences = locator.get();

  //check login
  static bool hasUsername() {
    return sharedPreferences.getString('username') != null;
  }

  static bool checkUsername() {
    String username = AuthManager.getUsername() ?? 'dont have username';
    if (username == 'dont have username') {
      print('Username does not exist');
      return false;
    } else {
      print('Username exists: $username');

      return true;
    }
  }
  // ذخیره توکن
  // static saveToken(String token) async {
  //   await sharedPreferences.setString('access_token', token);
  //   authNotifier.value = token;
  // }

  // خواندن توکن
  // static String readToken() {
  //   return sharedPreferences.getString('access_token') ?? '';
  // }

  // خروج کاربر
  static logout() {
    sharedPreferences.clear();
    authNotifier.value = null;
  }

  // ذخیره شناسه کاربر
  // static saveId(String id) async {
  //   await sharedPreferences.setString('user_id', id);
  // }

  // خواندن شناسه کاربر
  // static String getId() {
  //   return sharedPreferences.getString('user_id') ?? '';
  // }

  // ذخیره نام کاربری
  static saveUsername(String username) async {
    await sharedPreferences.setString('username', username);
  }

  // خواندن نام کاربری
  static String? getUsername() {
    return sharedPreferences.getString('username');
  }
}

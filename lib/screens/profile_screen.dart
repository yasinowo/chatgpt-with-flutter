import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ichat/them/fonts_style.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('profile'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // تصویر پروفایل
                Container(
                  width: 330.w,
                  height: 260.h,
                  decoration: BoxDecoration(
                      color: theme.colorScheme.inversePrimary,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      SizedBox(
                        width: 120.w,
                        height: 120.h,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: theme.colorScheme.primary,
                          child: Center(
                            child: SvgPicture.asset(
                              width: 130.w,
                              height: 130.h,
                              'assets/images/user_profile.svg',
                              alignment: Alignment.center,
                              fit: BoxFit.fitHeight,
                              colorFilter: ColorFilter.mode(
                                theme.colorScheme.surface,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        user?.userMetadata?['display_name'] ?? 'user name',
                        style: MyFonts.titleMedium
                            .copyWith(color: theme.colorScheme.tertiary),
                      ),
                      SizedBox(width: 10.h),
                      Text(
                        user?.email ?? 'email',
                        style: MyFonts.bodyLarge
                            .copyWith(color: theme.colorScheme.tertiary),
                      ),
                      SizedBox(height: 20.h),
                      editprofileButton(theme, context)
                    ]),
                  ),
                ),
                SizedBox(height: 10.h),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Recent Chats',
                        style: MyFonts.bodyLarge
                            .copyWith(color: theme.colorScheme.tertiary))),
                SizedBox(height: 10.h),
                historyBox(theme),
                SizedBox(height: 15.h),
                historyBox2(theme), SizedBox(height: 15.h),
                historyBox3(theme)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container historyBox(ThemeData theme) {
    return Container(
      width: 340.w,
      height: 70.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: theme.colorScheme.inversePrimary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Project Planning',
            style: MyFonts.bodyMedium.copyWith(
                color: theme.colorScheme.tertiary, fontWeight: FontWeight.w500),
          ),
          Text(
            'Yesterday',
            style: MyFonts.bodySmall.copyWith(color: theme.colorScheme.primary),
          )
        ],
      ),
    );
  }

  Container historyBox2(ThemeData theme) {
    return Container(
      width: 340.w,
      height: 70.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: theme.colorScheme.inversePrimary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Project Planning',
            style: MyFonts.bodyMedium.copyWith(
                color: theme.colorScheme.tertiary, fontWeight: FontWeight.w500),
          ),
          Text(
            'Yesterday',
            style: MyFonts.bodySmall.copyWith(color: theme.colorScheme.primary),
          )
        ],
      ),
    );
  }

  Container historyBox3(ThemeData theme) {
    return Container(
      width: 340.w,
      height: 70.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: theme.colorScheme.inversePrimary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Project Planning',
            style: MyFonts.bodyMedium.copyWith(
                color: theme.colorScheme.tertiary, fontWeight: FontWeight.w500),
          ),
          Text(
            'Yesterday',
            style: MyFonts.bodySmall.copyWith(color: theme.colorScheme.primary),
          )
        ],
      ),
    );
  }

  ElevatedButton editprofileButton(ThemeData theme, BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/edit_profile');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primaryContainer,
        foregroundColor: theme.colorScheme.tertiary,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        'Edit Profile',
        style: MyFonts.bodySmall.copyWith(
            color: theme.colorScheme.tertiary, fontWeight: FontWeight.bold),
      ),
    );
  }
}

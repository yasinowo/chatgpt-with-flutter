import 'package:flutter/material.dart';
import 'package:my_chat_gpt/components/appbar_global.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('profile'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // تصویر پروفایل
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                    'https://via.placeholder.com/150'), // جایگزین با آدرس تصویر پیش‌فرض
              ),
              SizedBox(height: 16),
              // نام نمایشی
              Text(
                user?.userMetadata?['full_name'] ?? 'نام نمایشی',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              // ایمیل
              Text(
                user?.email ?? 'ایمیل نامشخص',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 24),
              // دکمه ویرایش پروفایل
              ElevatedButton(
                onPressed: () {
                  // منطق ویرایش پروفایل
                },
                child: Text('ویرایش پروفایل'),
              ),
              SizedBox(height: 24),
              // لیست اطلاعات اضافی
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('شماره تلفن'),
                subtitle: Text(user?.userMetadata?['phone'] ?? 'نامشخص'),
              ),
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text('آدرس'),
                subtitle: Text(user?.userMetadata?['address'] ?? 'نامشخص'),
              ),
              // ... سایر اطلاعات اضافی
            ],
          ),
        ),
      ),
    );
  }
}

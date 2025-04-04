import 'package:shared_preferences/shared_preferences.dart';

Future<bool> checkToken() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('supabase_token');
  return token != null;
}

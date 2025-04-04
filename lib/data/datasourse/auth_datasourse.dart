import 'package:my_chat_gpt/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class IAuthDatasource {
  final SupabaseClient _client = Supabase.instance.client;

  Future<User?> signUp(UserModel user);
  Future<User?> signIn(UserModel user);
}

class AuthDataSource extends IAuthDatasource {
  @override
  Future<User?> signUp(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await _client.auth.signUp(
        email: user.email,
        password: user.password,
        data: {'display_name': user.displayName});

    await prefs.setString('supabase_token',
        Supabase.instance.client.auth.currentSession!.accessToken);
    return response.user;
  }

  @override
  Future<User?> signIn(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await _client.auth.signInWithPassword(
      email: user.email,
      password: user.password,
    );
    await prefs.setString('supabase_token',
        Supabase.instance.client.auth.currentSession!.accessToken);
    return response.user;
  }
}

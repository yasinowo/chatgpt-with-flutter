import 'package:my_chat_gpt/model/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class IAuthDatasource {
  final SupabaseClient _client = Supabase.instance.client;
  Future<User?> signUp(UserModel user);
  Future<User?> signIn(UserModel user);
}

class AuthDataSource extends IAuthDatasource {
  @override
  Future<User?> signUp(UserModel user) async {
    final response = await _client.auth.signUp(
      email: user.email,
      password: user.password,
    );
    return response.user;
  }

  @override
  Future<User?> signIn(UserModel user) async {
    final response = await _client.auth.signInWithPassword(
      email: user.email,
      password: user.password,
    );
    return response.user;
  }
}

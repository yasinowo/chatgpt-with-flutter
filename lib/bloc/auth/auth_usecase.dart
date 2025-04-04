import 'package:my_chat_gpt/data/repository/auth_repository.dart';
import 'package:my_chat_gpt/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpUseCase {
  final AuthRepository _repository = AuthRepository();

  Future<User?> execute(UserModel user) async {
    return _repository.signUp(user);
  }
}

class SignInUseCase {
  final AuthRepository _repository = AuthRepository();

  Future<User?> execute(UserModel user) async {
    return _repository.signIn(user);
  }
}

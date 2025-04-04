import 'package:my_chat_gpt/data/repository/auth_repository.dart';
import 'package:my_chat_gpt/model/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthUsecase {
  final AuthRepository _repository = AuthRepository();
}

class SignUpUseCase extends AuthUsecase {
  Future<User?> execute(UserModel user) async {
    return _repository.signUp(user);
  }
}

class SignInUseCase extends AuthUsecase {
  Future<User?> execute(UserModel user) async {
    return _repository.signIn(user);
  }
}

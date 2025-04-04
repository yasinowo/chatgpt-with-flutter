import 'package:my_chat_gpt/data/repository/auth_repository.dart';
import 'package:my_chat_gpt/model/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthUsecase {}

class SignUpUseCase extends AuthUsecase {
  final AuthRepository _repository = AuthRepository();

  Future<User?> execute(UserModel user) async {
    return _repository.signUp(user);
  }
}

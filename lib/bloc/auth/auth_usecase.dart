import 'package:my_chat_gpt/data/repository/auth_repository.dart';
import 'package:my_chat_gpt/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthUsecase {
  final SignUpUsecase signUp;
  final SignInUsecase signIn;

  AuthUsecase(this.signUp, this.signIn);
}

class SignUpUsecase {
  final AuthRepository _repository;

  SignUpUsecase(this._repository);

  Future<User?> execute(UserModel user) async {
    return _repository.signUp(user);
  }
}

class SignInUsecase {
  final AuthRepository _repository;

  SignInUsecase(this._repository);

  Future<User?> execute(UserModel user) async {
    return _repository.signIn(user);
  }
}

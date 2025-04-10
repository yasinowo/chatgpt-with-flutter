import 'package:ichat/data/datasourse/auth_datasourse.dart';
import 'package:ichat/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class IAuthRepository {
  final AuthDataSource _dataSource = AuthDataSource();

  Future<User?> signUp(UserModel user);
  Future<User?> signIn(UserModel user);
}

class AuthRepository extends IAuthRepository {
  @override
  Future<User?> signUp(UserModel user) async {
    return _dataSource.signUp(user);
  }

  @override
  Future<User?> signIn(UserModel user) {
    return _dataSource.signIn(user);
  }
}

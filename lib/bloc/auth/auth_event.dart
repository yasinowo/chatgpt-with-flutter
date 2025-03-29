part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthLoginRequestE extends AuthEvent {
  String username;
  String password;
  AuthLoginRequestE(this.username, this.password);
}

class AuthRegisterRequestE extends AuthEvent {
  String username;
  String password;
  String passwordConfirm;

  AuthRegisterRequestE(this.username, this.password, this.passwordConfirm);
}

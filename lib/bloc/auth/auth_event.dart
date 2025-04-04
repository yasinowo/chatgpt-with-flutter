part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class SignUp extends AuthEvent {
  final UserModel user;
  SignUp(this.user);
}

class SignIn extends AuthEvent {
  final UserModel user;

  SignIn(this.user);
}

class SignOutEvent extends AuthEvent {}

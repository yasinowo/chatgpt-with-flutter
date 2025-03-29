part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoadingS extends AuthState {}

final class AuthResponseS extends AuthState {}

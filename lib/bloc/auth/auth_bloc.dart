// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_chat_gpt/bloc/auth/auth_usecase.dart';
import 'package:my_chat_gpt/data/repository/auth_repository.dart';
import 'package:my_chat_gpt/model/user_model.dart';
import 'package:my_chat_gpt/util/auth_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase _signUpUseCase = SignUpUseCase();
  final SignInUseCase _signInUseCase = SignInUseCase();

  AuthBloc() : super(AuthInitial()) {
    on<SignUp>(
      (event, emit) async {
        emit(AuthLoading());
        try {
          final user = await _signUpUseCase.execute(event.user);
          emit(AuthSuccess(user));
          print(user);
        } on AuthException catch (e) {
          emit(AuthFailure(e.message));
          print(e.message);
        } catch (e) {
          emit(AuthFailure(e.toString()));
          print(e.toString());
        }
      },
    );
    on<SignIn>(
      (event, emit) async {
        emit(AuthLoading());
        try {
          final user = await _signInUseCase.execute(event.user);
          emit(AuthSuccess(user));
          print(user);
        } on AuthException catch (e) {
          emit(AuthFailure(e.message));
          print(e.message);
        } catch (e) {
          emit(AuthFailure(e.toString()));
          print(e.toString());
        }
      },
    );
  }

  // @override
  // Stream<AuthState> mapEventToState(AuthEvent event) async* {
  //   if (event is SignUp) {
  //     yield AuthLoading();
  //     try {
  //       final user = await _signUpUseCase.execute(event.user);
  //       yield AuthSuccess(user);
  //       print(user);
  //     } catch (e) {
  //       yield AuthFailure(e.toString());
  //       print(e.toString());
  //     }
  //   }
  //   if (event is SignIn) {
  //     yield AuthLoading();
  //     try {
  //       final user = await _signInUseCase.execute(event.user);
  //       yield AuthSuccess(user);
  //     } catch (e) {
  //       yield AuthFailure(e.toString());
  //     }
  //   }
  // }
}

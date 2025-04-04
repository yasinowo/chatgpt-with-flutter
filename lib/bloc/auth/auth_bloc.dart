// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
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
    @override
    Stream<AuthState> mapEventToState(AuthEvent event) async* {
      if (event is SignUp) {
        yield AuthLoading();
        try {
          final user = await _signUpUseCase.execute(event.user);
          yield AuthSuccess(user);
          print(user);
        } catch (e) {
          yield AuthFailure(e.toString());
          print(e.toString());
        }
      }
      if (event is SignIn) {
        yield AuthLoading();
        try {
          final user = await _signInUseCase.execute(event.user);
          yield AuthSuccess(user);
        } catch (e) {
          yield AuthFailure(e.toString());
        }
      }
    }
  }
  //befor supabase i create
  // on<AuthLoginRequestE>((event, emit) async {
  //   emit(AuthLoadingS());
  //   AuthManager.saveUsername(event.username);
  //   emit(AuthResponseS());
  //   print('login success : $event.username');
  // });
}

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final IAuthRepasitory repository = locator.get();
//   AuthBloc() : super(AuthInitiateState()) {
//     on<AuthLoginRequest>(
//       (event, emit) async {
//         emit(AuthStateLoading());
//         var response = await repository.login(event.username, event.password);
//         emit(AuthResponseState(response));
//       },
//     );
//     on<AuthRegisterRequest>(
//       (event, emit) async {
//         emit(AuthStateLoading());
//         var response = await repository.register(
//             event.username, event.password, event.passwordConfirm);
//         emit(AuthResponseState(response));
//       },
//     );
//   }
// }

// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:my_chat_gpt/util/auth_manager.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequestE>((event, emit) async {
      emit(AuthLoadingS());
      AuthManager.saveUsername(event.username);
      emit(AuthResponseS());
      print('login success : $event.username');
    });
  }
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

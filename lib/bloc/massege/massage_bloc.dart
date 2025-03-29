import 'package:bloc/bloc.dart';
import 'package:my_chat_gpt/bloc/massege/massage_event.dart';
import 'package:my_chat_gpt/bloc/massege/massage_state.dart';
import 'package:my_chat_gpt/data/di.dart';
import 'package:my_chat_gpt/data/repository/chat_repository.dart';

class MassageBloc extends Bloc<MassageEvent, MassageState> {
  final IChatRepository repository = locator.get();
  MassageBloc() : super(MassageInitialS()) {
    on<SendMassageE>(
      (event, emit) async {
        emit(MassageLoadingS());
        var resoinse = await repository.sendMessage(event.message);
        emit(MessageResponseS(resoinse));
      },
    );
  }
}

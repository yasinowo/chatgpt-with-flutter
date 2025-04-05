import 'package:bloc/bloc.dart';
import 'package:ichat/bloc/massege/massage_event.dart';
import 'package:ichat/bloc/massege/massage_state.dart';
import 'package:ichat/data/di.dart';
import 'package:ichat/data/repository/chat_repository.dart';

class MessegeBloc extends Bloc<MassageEvent, MassageState> {
  final IChatRepository repository = locator.get();
  MessegeBloc() : super(MassageInitialS()) {
    on<SendMassageE>(
      (event, emit) async {
        emit(MassageLoadingS());
        var resoinse = await repository.sendMessage(event.message);
        emit(MessageResponseS(resoinse));
      },
    );
  }
}

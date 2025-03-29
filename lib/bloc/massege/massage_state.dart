abstract class MassageState {}

class MassageInitialS extends MassageState {}

class MassageLoadingS extends MassageState {}

class MassageSendS extends MassageState {}

class MassageLoginS extends MassageState {}

class MessageResponseS extends MassageState {
  final String response;
  MessageResponseS(this.response);
}

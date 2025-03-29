abstract class MassageEvent {}

class SendMassageE extends MassageEvent {
  String message;
  SendMassageE(this.message);
}

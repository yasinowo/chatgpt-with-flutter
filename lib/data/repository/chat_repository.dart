import 'package:my_chat_gpt/data/datasourse/chat_datasource.dart';
import 'package:my_chat_gpt/data/di.dart';

abstract class IChatRepository {
  Future<String> sendMessage(String message);
  Future<void> saveMessage(String message, bool isUser);
}

class ChatRemotRepository implements IChatRepository {
  final IChatDataSource dataSource = locator.get();

  @override
  Future<String> sendMessage(String message) async {
    try {
      var response = await dataSource.sendMessage(message);
      return response;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<void> saveMessage(String message, bool isUser) async {
    try {
      await dataSource.saveMessage(message, isUser);
    } catch (e) {
      e.toString();
    }
  }
}

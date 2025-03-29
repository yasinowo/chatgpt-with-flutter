// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:my_chat_gpt/data/database/chat_database.dart';
import 'package:my_chat_gpt/data/di.dart';
import 'package:my_chat_gpt/model/massage.dart';
import 'package:my_chat_gpt/util/api_exception.dart';

abstract class IChatDataSource {
  Future<String> sendMessage(String message);
  Future<void> saveMessage(String message, bool isUser);
}

class ChatRemoteDataSource implements IChatDataSource {
  final Dio dio = locator.get();
  @override
  Future<String> sendMessage(String message) async {
    String userid = 'yasinxxx1';
    try {
      var response = await dio.request(
        'gpt-4-save/?text=$message&userid=$userid',
        options: Options(
          method: 'POST',
        ),
      );

      if (response.statusCode == 200) {
        var text = response.data;
        print(text);
        return text;
      } else {
        print(response.statusMessage);
        return response.statusMessage ?? 'response.statusMessage is null';
      }
    } on DioException catch (e) {
      throw ApiException(e.response?.statusCode, e.response?.data['message']);
    }
  }

  @override
  Future<void> saveMessage(String message, bool isUser) async {
    final chatMessage = ChatMessage(
      message: message,
      isUser: isUser,
      timestamp: DateTime.now().toIso8601String(),
    );
    await ChatDatabase().insertMessage(chatMessage);
  }
}

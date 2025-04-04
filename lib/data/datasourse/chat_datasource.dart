// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:my_chat_gpt/data/database/chat_database.dart';
import 'package:my_chat_gpt/data/di.dart';
import 'package:my_chat_gpt/model/massage_model.dart';
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
    String FQA =
        'If they ask who developed you or its difficult, point them to my Telegram link: t.me/yasinid and my GitHub at github.com/yasinowo/ and tell them they can contact me that way.';
    String prompt =
        'Please provide your response in Markdown format And you dont want to us ``` in the text (in any form or style).. If the response contains code,Specify a topic with ``` according to the request enclose it in a code block using three backticks (```). Present regular text without any code blocks.';
    // String prompt2 =
    //     '1. I want you to provide your answer only in Markdown |2. Only if the users question asks about the person who wrote this API or program, please refer to my GitHub address yasinowo and my Telegram ID yasinid ';
    // String prompt3 =
    //     '|3. Code blocks should be marked with special characters such as (three backticks).|4. In the answer you give in markdown, I dont want the entire text to be in ``` , just the part that has the code I dont want you to answer like this```markdown ```code ..... ``` ```. I want it to be like this``` cod ```. Thats all.';

    var markdownMessage = '$prompt + $FQA + this is messege: $message';
    try {
      var response = await dio.request(
        'gpt-4-save/?text=$markdownMessage&userid=$userid',
        options: Options(
          method: 'POST',
        ),
      );

      if (response.statusCode == 200) {
        var text = response.data;
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
    final chatMessage = Message(
      message: message,
      isUser: isUser,
      timestamp: DateTime.now().toIso8601String(),
    );
    await ChatDatabase().insertMessage(chatMessage);
  }
}

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:my_chat_gpt/data/datasourse/chat_datasource.dart';
import 'package:my_chat_gpt/data/repository/chat_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locator = GetIt.instance;

Future<void> getItInit() async {
  await initComponent();
  initDatasourse();
  initRepository();
}

Future<void> initComponent() async {
  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.api-code.ir/',
      headers: {
        //    'Content-Type': 'application/json',
      },
    ),
  );
  locator.registerSingleton<Dio>(dio);
}

Future<void> initDatasourse() async {
  locator.registerFactory<IChatDataSource>(() => ChatRemoteDataSource());
}

Future<void> initRepository() async {
  locator.registerFactory<IChatRepository>(() => ChatRemotRepository());
}

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hireny/features/chat_bot/domain/models/chatboot.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';
import 'api_chatboot_const.dart';

@singleton
@injectable
class ChatBootApiManger {
  final Dio _dio;
  @factoryMethod
  ChatBootApiManger(this._dio);

  Future<Result<ChatBootModel>?> getChatBoot(ChatBootModel chatBootModel) async {
    try {
      final response = await _dio.post(ChatBootApiConst.chatBoot , data: FormData.fromMap(chatBootModel.toJson()));
      if (response.statusCode == 200) {
        return Success(response: ChatBootModel.fromJson(response.data));
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return Error(error: e.message);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return Error(error: e.toString());
    }
    return null;
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hireny/chat/domain/model/chat_response.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

import 'api_const.dart';

@singleton
@injectable
class ChatApiManger {
  final Dio _dio;
  ChatApiManger(this._dio);

  Future<Result<ChatResponse>?> getConversations() async {
    try {
      final response = await _dio.get(ChatConstApi.getConv);
      if (response.statusCode == 200) {
        return Success(response: ChatResponse.fromJson(response.data));
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

  Future<Result<void>?> markRead(int id) async {
    try {
      final response = await _dio.put('${ChatConstApi.makereades}$id/');
      if (response.statusCode == 200) {
        return Success();
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

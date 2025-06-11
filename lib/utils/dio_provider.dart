import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'data_shared/shared_const_api.dart';

@module
abstract class DioProvider {
  @lazySingleton
  Dio dioProvider() {
    final Dio dio = Dio();
    dio.options.headers = {
      HttpHeaders.contentTypeHeader: 'multipart/form-data',
      if(AppSharedData.user?.accessToken != null)HttpHeaders.authorizationHeader:
          'Bearer ${AppSharedData.user?.accessToken}',
    };
    dio.options.baseUrl = ApiShared.baseUrl;
    if (kDebugMode) {
      dio.interceptors.add(providePretty());
    }
    return dio;
  }

  @lazySingleton
  PrettyDioLogger providePretty() {
    return PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
      enabled: kDebugMode,
    );
  }
}

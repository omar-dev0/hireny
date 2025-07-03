import 'package:dio/dio.dart';

import '../lang/lang.dart';

class DioExceptions implements Exception {
  final String message;

  DioExceptions({required this.message});

  factory DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return DioExceptions(message: Lang.connectionTimeout);
      case DioExceptionType.sendTimeout:
        return DioExceptions(message: Lang.sendTimeout);
      case DioExceptionType.receiveTimeout:
        return DioExceptions(message: Lang.receiveTimeout);
      case DioExceptionType.badResponse:
        return DioExceptions(
          message: handleHttpError(
            dioError.response?.statusCode,
            dioError.response?.statusMessage,
          ),
        );
      case DioExceptionType.cancel:
        return DioExceptions(message: Lang.requestCancelled);
      case DioExceptionType.unknown:
        return DioExceptions(
          message: "${Lang.unexpectedError} ${dioError.message}",
        );
      default:
        return DioExceptions(message: Lang.genericError);
    }
  }

  static String handleHttpError(int? statusCode, String? statusMessage) {
    switch (statusCode) {
      case 400:
        return Lang.otpExpiredOrIncorrect;
      case 401:
        return Lang.unauthorized;
      case 403:
        return Lang.forbidden;
      case 404:
        return Lang.notFound;
      case 422:
        return Lang.emailIncorrect;
      case 423:
        return Lang.emailExists;
      case 410:
        return Lang.otpExpiredOrIncorrect;
      case 500:
        return Lang.internalServerError;
      case 502:
        return Lang.badGateway;
      case 503:
        return Lang.serviceUnavailable;
      default:
        return "${Lang.invalidStatusCode} $statusCode. $statusMessage";
    }
  }

  @override
  String toString() => message;
}

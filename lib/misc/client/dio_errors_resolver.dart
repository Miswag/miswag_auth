import 'package:dio/dio.dart';

 Map<DioExceptionType, String> errors = {
	DioExceptionType.connectionTimeout: "CONNECT_TIMEOUT_ERROR_MESSAGE",
	DioExceptionType.sendTimeout: "SLOW_INTERNET_TIMEOUT_ERROR_MESSAGE",
	DioExceptionType.receiveTimeout: "SERVER_TIMEOUT_ERROR_MESSAGE",
};

String resolve(DioExceptionType type) => errors[type] ?? "CONNECT_TIMEOUT_ERROR_MESSAGE";
import 'package:dio/dio.dart';

 Map<DioErrorType, String> errors = {
	DioErrorType.connectTimeout: "CONNECT_TIMEOUT_ERROR_MESSAGE",
	DioErrorType.sendTimeout: "SLOW_INTERNET_TIMEOUT_ERROR_MESSAGE",
	DioErrorType.receiveTimeout: "SERVER_TIMEOUT_ERROR_MESSAGE",
};

String resolve(DioErrorType type) => errors[type];
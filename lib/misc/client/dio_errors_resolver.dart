import 'package:dio/dio.dart';

const Map<DioErrorType, String> errors = {
	DioErrorType.CONNECT_TIMEOUT: "CONNECT_TIMEOUT_ERROR_MESSAGE",
	DioErrorType.SEND_TIMEOUT: "SLOW_INTERNET_TIMEOUT_ERROR_MESSAGE",
	DioErrorType.RECEIVE_TIMEOUT: "SERVER_TIMEOUT_ERROR_MESSAGE",
};

String resolve(DioErrorType type) => errors[type];
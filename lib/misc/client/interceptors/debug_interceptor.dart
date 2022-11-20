import 'package:dio/dio.dart';

class DebugInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("[${options?.method} ${options?.path}]");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("[${response?.statusCode} $response] DATA => ${response.data}");

    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(
        "ERROR[${err?.response?.statusCode} $err] DATA => ${err?.response?.data}");
    super.onError(err, handler);
  }
}

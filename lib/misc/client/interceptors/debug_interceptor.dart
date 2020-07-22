import 'package:dio/dio.dart';

class DebugInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) {
    print("[${options?.method} ${options?.path}]");
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    print(
        "[${response?.statusCode} ${response?.request?.path}] DATA => ${response.data}");
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    print(
        "ERROR[${err?.response?.statusCode} ${err?.request?.path}] DATA => ${err?.response?.data}");
    return super.onError(err);
  }
}

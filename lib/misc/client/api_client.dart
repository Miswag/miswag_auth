import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiClient {
  final String baseUrl;
  final String tokenKey;

  Map<String, Object> authentication;

  Dio client;
  Dio authClient;

  ApiClient({
    @required this.baseUrl,
    this.tokenKey = "token",
  }) : assert(baseUrl != null) {
    final BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      }
    );
    authClient = Dio(options);
    client = Dio(options);
    client.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options) async {
          if (authentication != null) {
            options.queryParameters.addAll({
              tokenKey: authentication[tokenKey]
            });
          }
          return options;
        }));
  }


  Future<Response> responseInterceptor(Response response) async {
    if (authentication != null) {}
    return response;
  }

}

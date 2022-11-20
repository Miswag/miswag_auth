import 'package:dio/dio.dart';
import 'package:miswag_auth/misc/client/api_client.dart';
import 'package:miswag_auth/models/auth_options.dart';

class AuthenticationInterceptors extends InterceptorsWrapper {
  final ApiClient client;

  AuthenticationInterceptors({this.client}) : assert(client != null);
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (this.client.authentication != null) {
      injectToken(options);
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }

  void injectToken(RequestOptions options) {
    if (this.client.authOptions.tokenType == TokenType.GET) {
      options.queryParameters.addAll({
        this.client.authOptions.tokenKey:
            this.client.authentication[this.client.authOptions.tokenKey]
      });
    }

    if (this.client.authOptions.tokenType == TokenType.Bearer) {
      options.headers.addAll({
        this.client.authOptions.customAuthHeader:
            "Bearer ${this.client.authentication[this.client.authOptions.tokenKey]}"
      });
    }
  }
}

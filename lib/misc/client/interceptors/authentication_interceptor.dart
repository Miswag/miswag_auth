import 'package:dio/dio.dart';
import 'package:miswag_auth/misc/client/api_client.dart';
import 'package:miswag_auth/models/auth_options.dart';

class AuthenticationInterceptors extends InterceptorsWrapper {
  final ApiClient client;

  AuthenticationInterceptors({this.client}) : assert(client != null);

  @override
  Future onRequest(RequestOptions options) {
    if (this.client.authentication != null) {
      injectToken(options);
    }
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    return super.onError(err);
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

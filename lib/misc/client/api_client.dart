import 'package:dio/dio.dart';
import 'package:miswag_auth/misc/client/interceptors/authentication_interceptor.dart';
import 'package:miswag_auth/misc/client/interceptors/debug_interceptor.dart';
import 'package:miswag_auth/models/auth_options.dart';

class ApiClient {
  final AuthOptions authOptions;
  final bool debug;
  Map<String, Object> authentication;

  Dio client;
  Dio authClient;

  ApiClient(this.authOptions, {this.debug = false})
      : assert(authOptions != null) {
    final BaseOptions options = BaseOptions(
        baseUrl: authOptions.baseUrl,
        connectTimeout: 5000,
        receiveTimeout: 3000,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        });
    authClient = Dio(options);
    client = Dio(options);
    client.interceptors.add(AuthenticationInterceptors(client: this));
    if (debug) {
      client.interceptors.add(DebugInterceptor());
    }
  }
}

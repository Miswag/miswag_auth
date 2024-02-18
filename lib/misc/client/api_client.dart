import 'package:dio/dio.dart';
import 'package:miswag_auth/misc/client/interceptors/authentication_interceptor.dart';
import 'package:miswag_auth/misc/client/interceptors/debug_interceptor.dart';
import 'package:miswag_auth/models/auth_options.dart';

class ApiClient {
  final AuthOptions options;
  final AuthOptions authOptions;
  final bool debug;
  Map<String, Object> authentication;
  Dio client;
  Dio authClient;
  ApiClient(this.options, this.authOptions, {this.debug = false})
      : assert(authOptions != null, options != null) {
    final BaseOptions options = BaseOptions(
        baseUrl: this.options.baseUrl,
        connectTimeout: this.options.connectingTimeout,
        receiveTimeout: this.options.receivingTimeout,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        });
    final BaseOptions authOptions = BaseOptions(
        baseUrl: this.authOptions.baseUrl,
        connectTimeout: this.authOptions.connectingTimeout,
        receiveTimeout: this.authOptions.receivingTimeout,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        });
    authClient = Dio(authOptions);
    client = Dio(options);
    client.interceptors.add(AuthenticationInterceptors(client: this));
    authClient.interceptors.add(AuthenticationInterceptors(client: this));
    if (debug) {
      client.interceptors.add(DebugInterceptor());
    }
  }
}

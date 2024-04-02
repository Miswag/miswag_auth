import 'package:dio/dio.dart';
import 'package:miswag_auth/misc/client/api_client.dart';
import 'package:miswag_auth/misc/exceptions/login_api_exception.dart';

class LoginAPI {
  final ApiClient client;
  final String path;
  LoginAPI(this.client, this.path);

  Future<Map<String, Object>> login(String email, String password) async {
    try {
      final Response response = await client.authClient
          .post(path, queryParameters: {"email": email, "password": password});
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response?.data is Map)
          throw LoginAPIException(e.response?.data);
        else
          throw LoginAPIException({"error": e.response?.data});
      }
      rethrow;
    }
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:miswag_auth/misc/client/api_client.dart';
import 'package:miswag_auth/services/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

const kTokenField = "mswgauthobj";

class UserRepository {
  final ApiClient client;
  final String loginPath;
  LoginAPI loginAPI;
  UserRepository(ApiClient client, {this.loginPath = "login.php"}) : client = client, super() {
    loginAPI = LoginAPI(client, loginPath);
    getAuthentication().then((auth){
      if (auth != null) {
        client.authentication = auth;
      }
    });
  }

  Future<Map<String, Object>> authenticate({
    @required String email,
    @required String password,
  }) async {
    try {
      final authentication = await loginAPI.login(email, password);
      client.authentication = authentication;
      return authentication;
    } on DioError catch (e) {
      throw Exception(e.response.data["msg"]);
    }
  }

  Future<void> deleteToken() async {
    final storage = await SharedPreferences.getInstance();
    storage.remove(kTokenField);
  }

  Future<void> persistAuthentication(Map<String, Object> authObject) async {
    final storage = await SharedPreferences.getInstance();
    storage.setString(kTokenField, json.encode(authObject));
  }

  Future<Map<String, Object>> getAuthentication() async {
    final storage = await SharedPreferences.getInstance();
    final String _json = storage.getString(kTokenField);
    if (_json != null) {
      return json.decode(_json);
    }
    return null;
  }

  Future<bool> hasToken() async {
    final Map<String, Object> token = await getAuthentication();
    return token != null;
  }
}

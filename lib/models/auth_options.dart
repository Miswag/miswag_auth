import 'package:flutter/foundation.dart';

enum TokenType { Bearer, POST, GET }

class AuthOptions {
  final String baseUrl;
  final String loginPath;
  final String tokenKey;
  final String usernameKey;
  final String passwordKey;
  final TokenType tokenType;
  final String customAuthHeader;

  const AuthOptions(
      {@required this.baseUrl,
      this.loginPath = "login.php",
      this.tokenKey = "token",
      this.usernameKey = "username",
      this.passwordKey = "password",
      this.tokenType = TokenType.GET,
      this.customAuthHeader = "Authorization"})
      : assert(baseUrl != null);
}

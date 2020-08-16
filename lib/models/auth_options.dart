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
  final int connectingTimeout;
  final int receivingTimeout;

  const AuthOptions(
      {@required this.baseUrl,
      this.loginPath = "login.php",
      this.tokenKey = "token",
      this.usernameKey = "username",
      this.passwordKey = "password",
      this.tokenType = TokenType.GET,
      this.customAuthHeader = "Authorization",
      this.connectingTimeout = 5000,
      this.receivingTimeout = 6000})
      : assert(baseUrl != null);
}

class LoginAPIException implements Exception {
  final Map<dynamic, dynamic> response;
  LoginAPIException(this.response);
  @override
  String toString() => "LoginAPIException: ${this.response}";
}

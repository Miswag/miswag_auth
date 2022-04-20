import 'package:flutter_test/flutter_test.dart';
import 'package:miswag_auth/misc/client/api_client.dart';
import 'package:miswag_auth/models/auth_options.dart';

void main() {
//   test('test auth injection into headers', () async {
//     final AuthOptions options = AuthOptions(
//         baseUrl: "https://api.jsonbin.io/",
//         loginPath: "5ebcfb3a47a2266b14784142",
//         tokenType: TokenType.Bearer);
//     ApiClient api = ApiClient(options, debug: true);

//     api.authentication = {"token": "testing"};

//     final res = await api.client.get('/');

//     expect(res.request.headers[options.customAuthHeader], "Bearer testing");
//   });

//   test('test auth injection into GET', () async {
//     final AuthOptions options = AuthOptions(
//         baseUrl: "https://api.jsonbin.io/",
//         loginPath: "5ebcfb3a47a2266b14784142",
//         tokenType: TokenType.GET);
//     ApiClient api = ApiClient(options, debug: true);

//     api.authentication = {"token": "testing"};

//     final res = await api.client.get('/');

//     expect(res.request.queryParameters[options.tokenKey], "testing");
//   });
}

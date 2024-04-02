import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miswag_auth/bloc/bloc.dart';
import 'package:miswag_auth/misc/client/api_client.dart';
import 'package:miswag_auth/miswag_auth.dart';
import 'package:miswag_auth/models/auth_options.dart';
import 'package:miswag_auth/models/error_message.dart';

main() {
  AuthOptions autOpt = AuthOptions(
    baseUrl: "https://ops.miswag.co/api/auth/",
    tokenType: TokenType.Bearer,
  );
  AuthOptions opt = AuthOptions(
    baseUrl: "https://warehouse.miswag.co/api/legacy_shelfer/",
    tokenType: TokenType.Bearer,
  );
  Authentication.setup(options: opt, authOptions: autOpt);
  runApp(SampleApp());
}

class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Authentication(
        onAppStart: (context) => Scaffold(
          backgroundColor: Colors.redAccent,
          body: Center(
            child: TextButton(
              child: Text("Launch App"),
              onPressed: () => BlocProvider.of<AuthenticationBloc>(context)
                  .add(AppStarted()),
            ),
          ),
        ),
        onAuthenticated: (context) => Scaffold(
          backgroundColor: Colors.green,
          body: Center(
            child: TextButton(
              child: Text("Logout"),
              onPressed: () =>
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut()),
            ),
          ),
        ),
        onAuthentication: (context) => Scaffold(
          backgroundColor: Colors.limeAccent,
          body: Center(
            child: TextButton(
              child: Text("Login"),
              onPressed: () => BlocProvider.of<AuthenticationBloc>(context)
                  .add(LoggedIn(authentication: {"token": "hello"})),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginResponse {
  late String token;

  LoginResponse({required this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }
}

class ApiException implements Exception {
  final ErrorMessage errorMessage;
  ApiException(this.errorMessage);
}

// Service
class LoginAPI {
  final ApiClient client;
  LoginAPI(this.client);
  Future<LoginResponse> login(String email, String password) async {
    try {
      final res = await client.client
          .post('/login', data: {"email": email, "password": password});
      return LoginResponse.fromJson(res.data);
    } on DioException catch (e) {
      throw ApiException(ErrorMessage.fromMap(e.response?.data));
    } on Exception {
      throw Exception("Error");
    }
  }
}

// BloC
abstract class LoginEvent {}

class DoLogin extends LoginEvent {
  final String email, password;
  DoLogin(this.email, this.password);
}

enum StateType { Initial, Loading, Loaded, Failure }

class LoginState implements Equatable {
  final StateType stateType;
  LoginState(this.stateType);

  @override
  List<Object> get props => [stateType];

  @override
  bool get stringify => false;
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginAPI api;

  LoginBloc(this.api) : super(LoginState(StateType.Initial));

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is DoLogin) {
      // try-catch to handle different states
      yield LoginState(StateType.Loading);
      try {
        final res = api.login(event.email, event.password);
        yield LoginState(StateType.Loaded);
      } on ApiException catch (e) {
        yield LoginState(StateType.Failure);
      } on Exception catch (e) {
        // Something else might happen .. although we should be handling all kind of exceptions in a class possible NetworkException class etc..
      }
    }
  }
}

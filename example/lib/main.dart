import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miswag_auth/bloc/bloc.dart';
import 'package:miswag_auth/miswag_auth.dart';
import 'package:miswag_auth/models/auth_options.dart';

main() {
  const AuthOptions options = AuthOptions(
      baseUrl: "https://jsonbin.io/", loginPath: "5ebcfb3a47a2266b14784142");
  Authentication.setup(options: options);
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
            child: RaisedButton(
              child: Text("Launch App"),
              onPressed: () =>
                  context.bloc<AuthenticationBloc>().add(AppStarted()),
            ),
          ),
        ),
        onAuthenticated: (context) => Scaffold(
          backgroundColor: Colors.green,
          body: Center(
            child: RaisedButton(
              child: Text("Logout"),
              onPressed: () =>
                  context.bloc<AuthenticationBloc>().add(LoggedOut()),
            ),
          ),
        ),
        onAuthentication: (context) => Scaffold(
          backgroundColor: Colors.limeAccent,
          body: Center(
            child: RaisedButton(
              child: Text("Login"),
              onPressed: () => context
                  .bloc<AuthenticationBloc>()
                  .add(LoggedIn(authentication: {"token": "hello"})),
            ),
          ),
        ),
      ),
    );
  }
}

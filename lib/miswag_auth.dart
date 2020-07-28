library miswag_auth;

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:miswag_auth/bloc/bloc.dart';
import 'package:miswag_auth/misc/client/api_client.dart';
import 'package:miswag_auth/models/auth_options.dart';
import 'package:miswag_auth/repository/user_repository.dart';

final GetIt I = GetIt.instance;

class Authentication extends StatefulWidget {
  final Widget Function(BuildContext context) onAuthentication;
  final Widget Function(BuildContext context) onAuthenticated;
  final Widget Function(BuildContext context) onAppStart;

  const Authentication({
    Key key,
    @required this.onAuthentication,
    @required this.onAuthenticated,
    @required this.onAppStart,
  }) : super();

  @override
  State<StatefulWidget> createState() => _AuthenticationState();

  static setup({@required AuthOptions options}) {
    assert(options != null);
    I.registerLazySingleton(() => ApiClient(options));
    I.registerLazySingleton(() =>
        UserRepository(GetIt.I.get<ApiClient>(), loginPath: options.loginPath));
  }
}

class _AuthenticationState extends State<Authentication> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (_) =>
          AuthenticationBloc(userRepository: I.get<UserRepository>()),
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          print(state);
          if (state is AuthenticationUninitialized) {
            return widget.onAppStart(context);
          }

          if (state is AuthenticationAuthenticated) {
            return widget.onAuthenticated(context);
          }

          if (state is AuthenticationUnauthenticated) {
            return widget.onAuthentication(context);
          }

          return Text("...");
        },
      ),
    );
  }
}

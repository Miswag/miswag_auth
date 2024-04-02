import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent() : super();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';

  @override
  List<Object> get props => [this];
}

class LoggedIn extends AuthenticationEvent {
  final Map<String, Object> authentication;

  const LoggedIn({required this.authentication}) : super();

  @override
  String toString() => 'LoggedIn { Authentication Object: $authentication }';

  @override
  List<Object> get props => [authentication];
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';

  @override
  List<Object> get props => [this];
}

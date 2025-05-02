part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {}

class AuthenticationStarted extends AuthenticationEvent {}

class AuthenticationLoggedIn extends AuthenticationEvent {
  final dynamic user;

  AuthenticationLoggedIn(this.user);
}

class AuthenticationLoggedOut extends AuthenticationEvent {}

part of 'authentication_bloc.dart';

abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final dynamic user;

  AuthenticationAuthenticated(this.user);
}

class AuthenticationUnauthenticated extends AuthenticationState {}

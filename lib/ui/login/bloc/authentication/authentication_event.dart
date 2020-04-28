import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final FirebaseUser user;

  const LoggedIn({@required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() {
    return 'LoggedIn { token: $user }';
  }
}

class LoggedOut extends AuthenticationEvent {}


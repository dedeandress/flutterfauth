import 'package:equatable/equatable.dart';

class AuthenticationState extends Equatable {
  @override
  List<Object> get props => throw UnimplementedError();
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}
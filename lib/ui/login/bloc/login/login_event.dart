import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class GoogleLoginButtonPressed extends LoginEvent {
  const GoogleLoginButtonPressed();

  @override
  List<Object> get props => [];
}

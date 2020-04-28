import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterfauth/repository/login_repository.dart';
import 'package:flutterfauth/ui/login/bloc/authentication/authentication_event.dart';
import 'package:flutterfauth/ui/login/bloc/authentication/authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {

  final LoginRepository loginRepository;

  AuthenticationBloc({@required this.loginRepository})
      : assert(loginRepository!=null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async*{

    if(event is AppStarted) {
      final isLoggedIn = await loginRepository.isLogged();

      if(isLoggedIn) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await loginRepository.signOut();
      yield AuthenticationUnauthenticated();
    }

  }
}
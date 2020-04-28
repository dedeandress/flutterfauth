import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfauth/repository/login_repository.dart';
import 'package:flutterfauth/ui/login/bloc/authentication/authentication_bloc.dart';
import 'package:flutterfauth/ui/login/bloc/authentication/authentication_event.dart';
import 'package:flutterfauth/ui/login/bloc/login/login_event.dart';
import 'package:flutterfauth/ui/login/bloc/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({@required this.loginRepository, @required this.authenticationBloc})
      : assert(loginRepository != null),
        assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is GoogleLoginButtonPressed) {
      yield LoginLoading();

      try {
        final user = await loginRepository.signIn();

        authenticationBloc.add(LoggedIn(user: user));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}

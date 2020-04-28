import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfauth/repository/login_repository.dart';
import 'package:flutterfauth/ui/home/home.dart';
import 'package:flutterfauth/ui/login/bloc/authentication/authentication_bloc.dart';
import 'package:flutterfauth/ui/login/bloc/authentication/authentication_state.dart';
import 'package:flutterfauth/ui/login/login.dart';
import 'package:flutterfauth/ui/splash/splash_page.dart';
import 'package:flutterfauth/ui/widget/loading_indicator.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  final LoginRepository loginRepository;

  App({Key key, @required this.loginRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationUninitialized) {
            return SplashPage();
          }
          if (state is AuthenticationAuthenticated) {
            return HomePage(
              loginRepository: loginRepository,
            );
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginPage(
              loginRepository: loginRepository,
            );
          }
          if (state is AuthenticationLoading) {
            return LoadingIndicator();
          } else
            return Container();
        },
      ),
    );
  }
}

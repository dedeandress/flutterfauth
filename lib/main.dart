import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfauth/repository/login_repository.dart';
import 'package:flutterfauth/router/routes.dart';
import 'package:flutterfauth/ui/app.dart';
import 'package:flutterfauth/ui/login/bloc/authentication/authentication_bloc.dart';
import 'package:flutterfauth/ui/login/bloc/authentication/authentication_event.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition.toString());
    super.onTransition(bloc, transition);
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    print(event.toString());
    super.onEvent(bloc, event);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print(error.toString());
    super.onError(bloc, error, stackTrace);
  }
}

void main() {
  Fimber.plantTree(DebugTree());

  Fimber.plantTree(DebugTree.elapsed());
  Routes.createRoutes();

  BlocSupervisor.delegate = SimpleBlocDelegate();
  final loginRepository = LoginRepository();

  runApp(BlocProvider<AuthenticationBloc>(
    create: (context) {
      return AuthenticationBloc(loginRepository: loginRepository)
        ..add(AppStarted());
    },
    child: App(loginRepository: loginRepository,),
  ));
}

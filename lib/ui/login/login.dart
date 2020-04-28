import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfauth/repository/login_repository.dart';
import 'package:flutterfauth/ui/login/bloc/authentication/authentication_bloc.dart';
import 'package:flutterfauth/ui/login/bloc/login/login_bloc.dart';
import 'package:flutterfauth/ui/login/bloc/login/login_event.dart';
import 'package:flutterfauth/ui/login/bloc/login/login_state.dart';

class LoginPage extends StatelessWidget {
  final LoginRepository loginRepository;

  LoginPage({Key key, @required this.loginRepository})
      : assert(loginRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Login')),
      ),
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
              loginRepository: loginRepository);
        },
        child: Loginform(),
      ),
    );
  }
}

class Loginform extends StatefulWidget {
  @override
  _LoginformState createState() => _LoginformState();
}

class _LoginformState extends State<Loginform> {
  @override
  Widget build(BuildContext context) {
    _onLoginWithGoogleButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(GoogleLoginButtonPressed());
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'error : ${state.error}',
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Center(
            child: Column(
              children: <Widget>[
                Container(
                  width: 140.0,
                  height: 40.0,
                  child: OutlineButton(
                    onPressed: () => state is! LoginLoading
                        ? _onLoginWithGoogleButtonPressed()
                        : null,
                    child: state is! LoginLoading
                        ? Text(
                            'Login with Google',
                            style: TextStyle(color: Colors.red),
                          )
                        : Container(
                            height: 20.0,
                            width: 20.0,
                            child: CircularProgressIndicator(),
                          ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

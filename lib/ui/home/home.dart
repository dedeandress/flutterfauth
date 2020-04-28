import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfauth/repository/login_repository.dart';
import 'package:flutterfauth/ui/home/bloc/home_bloc.dart';
import 'package:flutterfauth/ui/home/bloc/home_event.dart';
import 'package:flutterfauth/ui/home/bloc/home_state.dart';
import 'package:flutterfauth/ui/login/bloc/authentication/authentication_bloc.dart';
import 'package:flutterfauth/ui/login/bloc/authentication/authentication_event.dart';
import 'package:flutterfauth/ui/widget/loading_indicator.dart';

class HomePage extends StatelessWidget {
  final LoginRepository loginRepository;

  HomePage({Key key, @required this.loginRepository})
      : assert(loginRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: BlocProvider(
        create: (context) {
          return HomeBloc(loginRepository: loginRepository);
        },
        child: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(FetchData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'error: ${state.error}',
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return LoadingIndicator();
          }
          if (state is ShowUserData) {
            return buildHome(state.user.displayName, context);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

Widget buildHome(String name, BuildContext context) {
  return Container(
    child: Column(
      children: <Widget>[
        Text('$name'),
        RaisedButton(
          child: Text('Logout'),
          onPressed: () {
            BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
          },
        ),
      ],
    ),
  );
}

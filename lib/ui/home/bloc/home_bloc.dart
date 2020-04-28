import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfauth/repository/login_repository.dart';
import 'package:flutterfauth/ui/home/bloc/home_event.dart';
import 'package:flutterfauth/ui/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LoginRepository loginRepository;

  HomeBloc({@required this.loginRepository}) : assert(loginRepository != null);

  @override
  HomeState get initialState => HomeInitial();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is FetchData) {
      yield HomeLoading();
      print('Home Loading');
      try {
        FirebaseUser user = await loginRepository.getUser();
        print('Home Loading : $user');
        yield ShowUserData(user: user);
      } catch (error) {
        yield HomeFailure(error: error.toString());
      }
    }
  }
}

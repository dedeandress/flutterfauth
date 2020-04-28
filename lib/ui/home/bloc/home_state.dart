import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class ShowUserData extends HomeState {
  final FirebaseUser user;

  const ShowUserData({@required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() {
    return user.toString();
  }
}

class HomeFailure extends HomeState {
  final String error;

  const HomeFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return "error: $error";
  }
}
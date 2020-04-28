import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class FetchData extends HomeEvent{
  const FetchData();

  @override
  // TODO: implement props
  List<Object> get props => [];
}
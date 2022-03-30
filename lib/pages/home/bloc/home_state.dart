import 'package:equatable/equatable.dart';
import 'package:supermarket_history/models/home_list.dart';

class HomeState extends Equatable {
  @override
  List<HomeList> get props => [];
}

class HomeLoadingState extends HomeState {}

class HomeStateLoaded extends HomeState {
  final List<HomeList> list;

  @override
  List<HomeList> get props => list;

  HomeStateLoaded({required this.list});
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState({required this.message});
}

class HomeStateEmptyList extends HomeState {}

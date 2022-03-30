import 'package:equatable/equatable.dart';
import 'package:supermarket_history/models/home_list.dart';

class HomeEvent extends Equatable {
  @override
  List<HomeList> get props => [];
}

class HomeFetchList extends HomeEvent {}

class HomeFetchListWithError extends HomeEvent {}

class HomeFetchListWithEmptyList extends HomeEvent {}

class HomeAddList extends HomeEvent {
  final HomeList newHomeList;
  HomeAddList(this.newHomeList);
}

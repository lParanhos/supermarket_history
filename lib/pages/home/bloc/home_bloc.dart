import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket_history/models/home_list.dart';
import 'package:supermarket_history/repositories/shopping_list_repository.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._shopping_list_repository) : super(HomeLoadingState()) {
    on<HomeFetchList>(_fetchList);
    on<HomeAddList>(_addList);
  }

  final ShoppingListRepository _shopping_list_repository;

//TODO: USE THIS LINK TO CONTINUE: https://github.com/VGVentures/bloc_concurrency_demos/blob/main/lib/files/bloc/file_events.dart
  void _addList(
    HomeAddList event,
    Emitter<HomeState> emit,
  ) async {
    try {
      List<HomeList> newList = [...state.props, event.newHomeList];
      await _shopping_list_repository.setList(event.newHomeList);

      emit(HomeLoadingState());
      emit(HomeStateLoaded(list: newList));
    } catch (e) {
      print(e);
      emit(HomeErrorState(message: 'Ooops problemas ao salvar'));
    }
  }

  void _fetchList(
    HomeFetchList event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    try {
      final list = await _shopping_list_repository.getShoppingList();
      print(list);
      emit(HomeStateLoaded(list: list));
    } catch (_) {
      emit(HomeErrorState(message: 'Oooops :('));
    }
  }
}

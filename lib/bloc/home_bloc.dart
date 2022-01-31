import 'dart:async';

import 'package:supermarket_history/bloc/bloc.dart';
import 'package:supermarket_history/models/shopping_list.dart';

class HomeBloc implements Bloc {
  HomeBloc() {
    _shoppingProductsListController.sink.add([]);
  }

  List<ShoppingProductsList> _shoppingProductsList = [];

  /* StreamController manage the stram and sink for this BLoC.
  *  StreamController uses a generics to tell the type system what kind of object will be emitted from stream
  * */
  final _shoppingProductsListController =
      StreamController<List<ShoppingProductsList>>();

  /* Expose public getter to the ScreamController's stream */
  Stream<List<ShoppingProductsList>> get shoppingProductsListStream =>
      _shoppingProductsListController.stream;

  /* This functions represents the input for the BLoC
  * A ShoppingProductsList model object will be provided as parameter that is cached in the object’s private
  * _shoppingProductsList property and then added to sink for the stream
  * */
  void createNewShoppingProductsList(
    ShoppingProductsList newShoppingProductsList,
  ) {
    final updatedList = [..._shoppingProductsList, newShoppingProductsList];
    _shoppingProductsList = updatedList;
    _shoppingProductsListController.sink.add(updatedList);
  }

  /* Clean up method, the StreamController is closed when this object is deallocated.
  * If  you do not do  this, the IDE will complain that the StreamController is leaking.
  * */
  @override
  void dispose() {
    _shoppingProductsListController.close();
  }
}

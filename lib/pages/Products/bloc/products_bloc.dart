import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket_history/models/product.dart';
import 'package:supermarket_history/pages/Products/bloc/products_event.dart';
import 'package:supermarket_history/pages/Products/bloc/products_state.dart';
import 'package:supermarket_history/repositories/product_list_repository.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc(this._productListRepository) : super(ProductsLoadingState()) {
    on<ProductsFetch>(_fetch);
    on<ProductsAdd>(_addProduct);
    on<ProductRemove>(_removeProduct);
  }

  final ProductListRepository _productListRepository;

  void _fetch(
    ProductsFetch event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoadingState());

    final List<Product> result =
        await _productListRepository.getProducts(event.productId);
    if (result.isEmpty) emit(ProductsStateEmptyList());

    emit(ProductsStateLoaded(list: result));
  }

  void _addProduct(
    ProductsAdd event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoadingState());
    List<Product> newList = [...state.props, event.newProduct];

    await _productListRepository.addProduct(event.newProduct);

    emit(ProductsStateLoaded(list: newList));
  }

  void _removeProduct(
    ProductRemove event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoadingState());
    final updatedList =
        await _productListRepository.removeProduct(event.productId);
    emit(ProductsStateLoaded(list: updatedList));
  }
}

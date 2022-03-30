import 'package:equatable/equatable.dart';
import 'package:supermarket_history/models/product.dart';

class ProductsState extends Equatable {
  @override
  List<Product> get props => [];

  int get productsAmount => 0;

  String get total => '';
}

class ProductsLoadingState extends ProductsState {}

class ProductsStateLoaded extends ProductsState {
  final List<Product> list;

  @override
  List<Product> get props => list;

  @override
  int get productsAmount => props.length;

  @override
  String get total {
    double _total = 0;
    for (Product product in props) {
      _total += product.price * product.amount;
    }

    return 'R\$${_total.toStringAsFixed(2)}';
  }

  ProductsStateLoaded({required this.list});
}

class ProductsErrorState extends ProductsState {
  final String message;

  ProductsErrorState({required this.message});
}

class ProductsStateEmptyList extends ProductsState {}

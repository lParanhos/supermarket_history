import 'package:equatable/equatable.dart';
import 'package:supermarket_history/models/product.dart';

class ProductsEvent extends Equatable {
  @override
  List<Product> get props => [];
}

class ProductsFetch extends ProductsEvent {
  final String productId;
  ProductsFetch(this.productId);
}

class ProductsFetchWithError extends ProductsEvent {}

class ProductsFetchWithEmptyList extends ProductsEvent {}

class ProductsAdd extends ProductsEvent {
  final Product newProduct;
  ProductsAdd(this.newProduct);
}

class ProductRemove extends ProductsEvent {
  final int productId;
  ProductRemove(this.productId);
}

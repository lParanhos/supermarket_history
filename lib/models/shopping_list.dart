import 'package:supermarket_history/models/Product.dart';

class ShoppingProductsList {
  String? id;
  String createdAt;
  String? productListId;
  String title;
  List<Product> productsList;

  ShoppingProductsList({
    required this.createdAt,
    required this.title,
    this.productsList = const [],
    this.productListId,
  });
}

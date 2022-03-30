import 'package:supermarket_history/models/Product.dart';

class HomeList {
  String? id;
  String createdAt;
  String? productListId;
  String title;
  List<Product> productsList;

  HomeList({
    this.id,
    required this.createdAt,
    required this.title,
    this.productsList = const [],
    this.productListId,
  });

  factory HomeList.fromMap(Map<String, Object?> map) => HomeList(
        id: map['shoppingListId'].toString(),
        title: map['title'].toString(),
        createdAt: map['created_at'].toString(),
        productListId: '',
        productsList: [],
      );

  Map<String, Object?> toJSON() => {
        'title': title,
        'created_at': createdAt,
      };
}

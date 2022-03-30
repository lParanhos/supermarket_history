import 'package:sqflite/sqflite.dart';
import 'package:supermarket_history/data/database_helper.dart';
import 'package:supermarket_history/models/product.dart';

class ProductListRepository {
  late Database db;

  List<Product>? _products;

  getProducts(String shoppingListId) async {
    db = await DB.instance.database;
    List result = await db.query(DB.PRODUCTS_TABLE_KEY,
        where: 'shoppingListId = ?', whereArgs: [int.tryParse(shoppingListId)]);
    _products = result.map((e) => Product.fromMap(e)).toList();
    return _products;
  }

  _countItems(String shoppingListId) async {
    db = await DB.instance.database;
    List result = await db.query(DB.PRODUCTS_TABLE_KEY);
  }

  addProduct(Product newProduct) async {
    db = await DB.instance.database;
    db.insert(DB.PRODUCTS_TABLE_KEY, newProduct.toJSON());
    _products?.add(newProduct);
  }

  removeProduct(int productId) async {
    db = await DB.instance.database;
    db.delete(DB.PRODUCTS_TABLE_KEY, where: 'id = ?', whereArgs: [productId]);
    _products?.removeWhere((element) => element.id == productId);

    return _products;
  }
}

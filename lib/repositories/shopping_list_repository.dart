import 'package:sqflite/sqlite_api.dart';
import 'package:supermarket_history/data/database_helper.dart';
import 'package:supermarket_history/models/home_list.dart';

class ShoppingListRepository {
  late Database db;

  List<HomeList>? _list;

  ShoppingListRepository() {
    _initRepository();
  }

  _initRepository() async {
    await getShoppingList();
  }

  getShoppingList() async {
    if (_list != null) return _list;

    db = await DB.instance.database;
    List shoppingLists = await db.query(DB.SHOPPING_LIST_TABLE_KEY);
    _list = shoppingLists.map((item) => HomeList.fromMap(item)).toList();

    return _list;
  }

  setList(HomeList newList) async {
    db = await DB.instance.database;
    int id = await db.insert(DB.SHOPPING_LIST_TABLE_KEY, newList.toJSON());
    newList.id = id.toString();
    _list?.add(newList);
  }
}

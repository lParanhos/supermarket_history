import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  DB._();

  static final DB instance = DB._();

  static Database? _database;

  static const PRODUCTS_TABLE_KEY = 'products';
  static const SHOPPING_LIST_TABLE_KEY = 'shopping_list';

  get database async {
    if (_database != null) return _database;

    return await _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'supermarket_history'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(db, version) async {
    print('CREATING');
    await db.execute(_shoppingList);
    await db.execute(_products);
  }

  String get _shoppingList => '''
    CREATE TABLE $SHOPPING_LIST_TABLE_KEY(
    shoppingListId INTEGER PRIMARY KEY AUTOINCREMENT,
    created_at TEXT,
    title TEXT
    );
  ''';

  String get _products => '''
    CREATE TABLE $PRODUCTS_TABLE_KEY(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    shoppingListId INTEGER,
    name TEXT,
    unit TEXT,
    price REAL,
    amount REAL
    completed INTEGER
    "FOREIGN KEY(shoppingListId) REFERENCES shopping_list(shoppingListId)"
    );
  ''';
}

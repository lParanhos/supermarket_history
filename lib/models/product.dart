class Product {
  int? id;
  String name;
  String unit;
  double price;
  double amount;
  int shoppingListId;

  Product({
    this.id,
    this.price = 0,
    this.amount = 0,
    required this.shoppingListId,
    required this.name,
    required this.unit,
  });

  factory Product.fromMap(Map<String, Object?> map) => Product(
        id: int.parse(map['id'].toString()),
        name: map['name'].toString(),
        unit: map['unit'].toString(),
        amount: double.parse(map['amount'].toString()),
        price: double.parse(map['price'].toString()),
        shoppingListId: int.parse(
          map['shoppingListId'].toString(),
        ),
      );

  Map<String, Object?> toJSON() => {
        'name': name,
        'unit': unit,
        'price': price,
        'amount': amount,
        'shoppingListId': shoppingListId,
      };
}

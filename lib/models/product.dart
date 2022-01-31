class Product {
  String? id;
  String name;
  String unit;
  double price;
  double amount;

  Product({
    this.id,
    this.price = 0,
    this.amount = 0,
    required this.name,
    required this.unit,
  });
}

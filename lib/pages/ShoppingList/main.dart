import 'package:flutter/material.dart';
import 'package:supermarket_history/models/product.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({Key? key}) : super(key: key);

  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  List<Product> _shoppingList = [];

  void onSave() {
    setState(() {
      final newProduct = Product(
        amount: double.tryParse(_amountController.text) ?? 0,
        name: _nameController.text,
        price: double.tryParse(_priceController.text) ?? 0,
        unit: _unitController.text,
      );

      _shoppingList = [..._shoppingList, newProduct];
    });
  }

  void _openCreateList(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * .4,
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Wrap(
              alignment: WrapAlignment.end,
              crossAxisAlignment: WrapCrossAlignment.end,
              children: <Widget>[
                Text('Adicionar novo produto'),
                TextFormField(
                  controller: _nameController,
                  decoration:
                      const InputDecoration(label: Text('Nome do produto')),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: _amountController,
                        decoration: const InputDecoration(label: Text('Qtd')),
                      ),
                    ),
                    const SizedBox(
                      width: 30.0,
                    ),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: _unitController,
                        decoration:
                            const InputDecoration(label: Text('Unidade')),
                      ),
                    ),
                    const SizedBox(
                      width: 30.0,
                    ),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: _priceController,
                        decoration:
                            const InputDecoration(label: Text('Ex: Price')),
                      ),
                    ),
                  ],
                ),
                OutlinedButton(onPressed: onSave, child: Text('Salvar'))
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Wrap(
          direction: Axis.vertical,
          children: [Text('Created at 18.07'), Text('My title')],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [Text('Products'), Text(' (13)')],
                ),
                Row(
                  children: [Text('Total: '), Text('R\$78.84')],
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 24.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Bolo de cenoura...',
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25.0),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _shoppingList.length,
                itemBuilder: (ctx, index) {
                  return ShoppingListItem(_shoppingList[index]);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openCreateList(context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ShoppingListItem extends StatelessWidget {
  final Product item;

  const ShoppingListItem(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.cyan.withOpacity(0.1),
      ),
      child: ListTile(
        title: Wrap(
          children: [
            Text(item.name),
            Visibility(
              visible: item.amount > 0,
              child: Text(' | ${item.amount}${item.unit}'),
            ),
          ],
        ),
        subtitle: Text('${item.price}'),
        leading: Checkbox(
          onChanged: (value) {},
          value: false,
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket_history/models/product.dart';
import 'package:supermarket_history/pages/Products/bloc/products_bloc.dart';
import 'package:supermarket_history/pages/Products/bloc/products_event.dart';
import 'package:supermarket_history/pages/Products/bloc/products_state.dart';
import 'package:supermarket_history/utils/date_formatters.dart';

class ProductList extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  final String shoppingListId;
  final String shoppingListTitle;
  final String formattedCreationDate;

  ProductList({
    Key? key,
    this.shoppingListId = '',
    this.shoppingListTitle = '',
    this.formattedCreationDate = '',
  }) : super(key: key);

  void _onSave(BuildContext context) {
    final newProduct = Product(
      shoppingListId: int.parse(shoppingListId),
      amount: double.tryParse(_amountController.text) ?? 0,
      name: _nameController.text,
      price: double.tryParse(_priceController.text) ?? 0,
      unit: _unitController.text,
    );

    BlocProvider.of<ProductsBloc>(context).add(ProductsAdd(newProduct));
  }

  void _onDelete(BuildContext context, int productId) {
    BlocProvider.of<ProductsBloc>(context).add(ProductRemove(productId));
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
                const Text('Adicionar novo produto'),
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
                OutlinedButton(
                    onPressed: () => _onSave(context),
                    child: const Text('Salvar'))
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductsBloc>(context).add(ProductsFetch(shoppingListId));
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Wrap(
          direction: Axis.vertical,
          children: [
            Text('Criado em $formattedCreationDate'),
            Text(shoppingListTitle)
          ],
        ),
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(builder: (context, state) {
        if (state is ProductsErrorState) {
          return Center(
            child: Text(state.message),
          );
        }

        if (state is ProductsStateEmptyList) {
          return const Center(
            child: Text('Não há dados disponíveis.'),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text('Products'),
                      Text(' (${state.productsAmount})')
                    ],
                  ),
                  Row(
                    children: [const Text('Total: '), Text(state.total)],
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
                  itemCount: state.props.length,
                  itemBuilder: (ctx, index) {
                    return ShoppingListItem(
                      item: state.props[index],
                      onDelete: _onDelete,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
      /* , */
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
  final Function(BuildContext, int) onDelete;

  const ShoppingListItem({
    Key? key,
    required this.item,
    required this.onDelete,
  }) : super(key: key);

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
          onPressed: () => onDelete(context, item.id!),
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

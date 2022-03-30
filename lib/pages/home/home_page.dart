import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket_history/models/home_list.dart';
import 'package:supermarket_history/pages/Products/main.dart';
import 'package:supermarket_history/pages/home/bloc/home_event.dart';
import 'package:supermarket_history/utils/date_formatters.dart';

import 'bloc/home_bloc.dart';
import 'bloc/home_state.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void onSave(BuildContext context) {
    final HomeList newList = HomeList(
      title: _titleController.text,
      createdAt: DateTime.now().toString(),
    );
    BlocProvider.of<HomeBloc>(context).add(HomeAddList(newList));
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
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(label: Text('Titulo')),
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(label: Text('Descrição')),
                ),
                OutlinedButton(
                    onPressed: () => onSave(context),
                    child: const Text('Salvar'))
              ],
            ),
          ),
        );
      },
    );
  }

  void goToList(
    BuildContext context,
    String shoppingListId,
    String shoppingListTitle,
    String formattedCreationDate,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return ProductList(
            shoppingListId: shoppingListId,
            shoppingListTitle: shoppingListTitle,
            formattedCreationDate: formattedCreationDate,
          );
        },
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historico de compras'),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        if (state is HomeStateLoaded) {
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: state.list.length,
            itemBuilder: (context, index) {
              final formattedCreationDate =
                  formatToDDMMYYYY(state.list[index].createdAt);

              return ListItem(
                state.list[index],
                formattedCreationDate: formattedCreationDate,
                onPress: () => goToList(
                  context,
                  state.list[index].id!,
                  state.list[index].title,
                  formattedCreationDate,
                ),
              );
            },
          );
        }

        if (state is HomeErrorState) {
          return Center(
            child: Text(state.message),
          );
        }

        if (state is HomeStateEmptyList) {
          return const Center(
            child: Text('Não há dados disponíveis.'),
          );
        }

        return const Center(child: CircularProgressIndicator());
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openCreateList(context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final HomeList item;
  final VoidCallback onPress;
  final String formattedCreationDate;

  const ListItem(this.item,
      {Key? key, required this.onPress, required this.formattedCreationDate})
      : super(key: key);

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
            Text(item.title),
            Text(' | $formattedCreationDate'),
          ],
        ),
        subtitle: const Text('Items count'),
        trailing: IconButton(
          onPressed: onPress,
          icon: Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

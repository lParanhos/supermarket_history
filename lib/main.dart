import 'package:flutter/material.dart';
import 'package:supermarket_history/bloc/home_bloc.dart';
import 'package:supermarket_history/models/shopping_list.dart';
import 'package:supermarket_history/pages/ShoppingList/main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => const MyHomePage(title: 'Flutter Demo Home Pages'),
        'shopping_list_page': (ctx) => const ShoppingList(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final HomeBloc _homeBloc = HomeBloc();

  void onSave() {
    final ShoppingProductsList newList = ShoppingProductsList(
      title: _titleController.text,
      createdAt: DateTime.now().toString(),
    );
    _homeBloc.createNewShoppingProductsList(newList);
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
                OutlinedButton(onPressed: onSave, child: Text('Salvar'))
              ],
            ),
          ),
        );
      },
    );
  }

  void goToList() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const ShoppingList();
        },
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: StreamBuilder(
            stream: _homeBloc.shoppingProductsListStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const Center(
                    child: Text('Loading ...'),
                  );

                default:
                  if (snapshot.hasError) {
                    print('Error ${snapshot.error}');
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return ListItem(
                          snapshot.data[index],
                          onPress: goToList,
                        );
                      },
                    );
                  }
              }
            })
        /*ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: _list.length,
          itemBuilder: (BuildContext ctx, index) {
            return ListItem(
              _list[index],
              onPress: goToList,
            );
          },
        )*/
        ,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openCreateList(context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final ShoppingProductsList item;
  final VoidCallback onPress;

  const ListItem(this.item, {Key? key, required this.onPress})
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
            Text(' | ${item.createdAt}'),
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

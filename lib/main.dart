import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket_history/models/home_list.dart';
import 'package:supermarket_history/pages/Products/bloc/products_bloc.dart';
import 'package:supermarket_history/pages/Products/main.dart';
import 'package:supermarket_history/pages/home/bloc/home_bloc.dart';
import 'package:supermarket_history/pages/home/bloc/home_event.dart';
import 'package:supermarket_history/pages/home/home_page.dart';
import 'package:supermarket_history/repositories/product_list_repository.dart';
import 'package:supermarket_history/repositories/shopping_list_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HomeBloc(
            ShoppingListRepository(),
          )..add(
              HomeFetchList(),
            ),
        ),
        BlocProvider(
          create: (_) => ProductsBloc(
            ProductListRepository(),
          ),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (ctx) => HomePage(),
          'products': (ctx) => ProductList(),
        },
      ),
    );
  }
}

/* class MyHomePage extends StatefulWidget {
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
    final HomeList newList = HomeList(
      title: _titleController.text,
      createdAt: DateTime.now().toString(),
    );
    //_homeBloc.createNewShoppingProductsList(newList);
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
                OutlinedButton(onPressed: onSave, child: const Text('Salvar'))
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
            stream: _homeBloc.stream,
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
 */
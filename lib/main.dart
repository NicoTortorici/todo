// Tortorici Nico, 5CIA, 18/02/2022

import 'package:flutter/material.dart';
import 'package:todo/pages/new_page.dart';

import 'models/TodoItem.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'ToDo Tortorici'),
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
  final List<TodoItem> _items = [
    TodoItem(title: 'Fare la spesa', description: 'Fare la spesa, ecc, ecc,'),
    TodoItem(
        title: 'Fare la spesa 2', description: 'Fare la spesa 2, ecc, ecc,'),
  ];

  /// Aggiunge un oggetto alla lista.
  void _addTodo(TodoItem item) {
    setState(() {
      _items.add(item);
    });

    _showSnackbar('Aggiunto ${item.title}', 2);
  }

  void _showSnackbar(String text, int duration) {
    final snackbar = SnackBar(
      duration: Duration(seconds: duration),
      content: Text(text),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (context, index) {
            final todo = _items[index];

            return ListTile(
              title: Text(todo.title),
              subtitle: Text(todo.description),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(todo.title),
                    content: Text(todo.description),
                    actions: <Widget>[
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.red),
                        ),
                        child: const Text('Rimuovi'),
                        onPressed: () {
                          // Rimuovi l'oggetto.
                          setState(() => _items.remove(todo));
                          Navigator.of(ctx).pop(true);
                          _showSnackbar('Rimosso ${todo.title}', 2);
                        },
                      ),
                      ElevatedButton(
                        autofocus: true,
                        child: const Text('Ok'),
                        onPressed: () => Navigator.of(ctx).pop(true),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => NewPage(_addTodo))),
        tooltip: 'Aggiungi Todo',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

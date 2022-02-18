import 'package:flutter/material.dart';
import 'package:todo/models/TodoItem.dart';

class NewPage extends StatefulWidget {
  final Function(TodoItem) callback;

  const NewPage(this.callback, {Key? key}) : super(key: key);

  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuovo ToDo'),
      ),
      body: 
      Padding(
        
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Titolo',
                ),
                validator: (value) {

                  if (value == null) return "Inserire un valore";
                  if (value.isEmpty) return "Inserire almeno un carattere";
                  if (value.length > 20) return "Titolo troppo lungo";
                },
                controller: _titleController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Descrizione',
                ),
                controller: _descriptionController,
                validator: (value) {

                  if (value == null) return "Inserire un valore";
                  if (value.isEmpty) return "Inserire almeno un carattere";
                  if (value.length > 50) return "Descrizione troppo lunga";
                },
              ),
              ElevatedButton(
                child: const Text('Aggiungi'),
                onPressed: () {


                  if (_formKey.currentState!.validate())
                  {
                      widget.callback(TodoItem(
                        title: _titleController.text,
                        description: _descriptionController.text,),);


                      Navigator.of(context).pop(true);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

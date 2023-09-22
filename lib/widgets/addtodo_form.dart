import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddTodoForm extends ConsumerStatefulWidget {
  const AddTodoForm({super.key});

  @override
  _AddTodoFormState createState() => _AddTodoFormState();
}

class _AddTodoFormState extends ConsumerState<AddTodoForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return SizedBox(
      width: mediaQuery.width * 0.05,
      height: mediaQuery.height * 0.05,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 0,
          semanticContainer: true,
          //color: Colors.deepPurple,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    label: Text('Title'),
                  ),
                ),
                SizedBox(
                  height: mediaQuery.height * 0.02,
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    label: Text('Description'),
                  ),
                ),
                SizedBox(
                  height: mediaQuery.height * 0.05,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Save'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

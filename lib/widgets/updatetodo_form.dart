import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_graphql_app/routing/app_router.dart';
import 'package:todo_graphql_app/screens/home/presentation/home_controller.dart';

class UpdateTodoForm extends ConsumerStatefulWidget {
  //const UpdateTodoForm({super.key});
  final String id;
  final String title;
  final String description;
  final VoidCallback onTapBtn;

  UpdateTodoForm(
      {required this.description,
      required this.id,
      required this.title,
      required this.onTapBtn});

  @override
  _UpdateTodoFormState createState() => _UpdateTodoFormState();
}

class _UpdateTodoFormState extends ConsumerState<UpdateTodoForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(homeControllerProvider, (previousState, state) {
      if (!state.isLoading && state.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.error.toString()),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ));
      }
    });

    final state = ref.watch(homeControllerProvider);

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
                  onPressed: () async {
                    final success = await ref
                        .read(homeControllerProvider.notifier)
                        .updateTodo(widget.id, _titleController.text,
                            _descriptionController.text);
                    print('success: $success');
                    if (success) {
                      widget.onTapBtn();
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Updated successfully'),
                        backgroundColor: Colors.deepPurple,
                        behavior: SnackBarBehavior.floating,
                      ));
                    }
                  },
                  child: (state.isLoading)
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const Text('Save'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

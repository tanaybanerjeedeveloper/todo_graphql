import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_graphql_app/local_storage.dart';
import 'package:todo_graphql_app/screens/home/data/home_repository.dart';
import 'package:todo_graphql_app/screens/home/presentation/home_controller.dart';
import 'package:todo_graphql_app/screens/home/presentation/todo_widget.dart';
import 'package:todo_graphql_app/widgets/addtodo_form.dart';

class MyHomePage extends ConsumerStatefulWidget {
  //const MyHomePage({super.key, required this.title});

  //final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState

    setState(() {});
  }

  void reload() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('object');
    final mediaQiuery = MediaQuery.of(context).size;
    final dataValue = ref.watch(fetchToDosProvider);

    return dataValue.when(
      data: (data) {
        print('data: $data');
        return Scaffold(
          appBar: AppBar(
            // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text('TODO'),
          ),
          body: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) => TodoWidget(
                description: data[index].description,
                id: data[index].id,
                title: data[index].title),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // var a = localStorageNew.getString('token');
              // print(a);
              _openForm(context, reload);
              //setState(() {});
            },
            child: const Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => const Center(
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: Text('Error'),
        ),
      ),
    );
  }

  void _openForm(ctx, onTapping) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        insetPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        // insetPadding: EdgeInsets.all(),
        child: SizedBox(
          width: 400,
          height: 400,
          child: AddTodoForm(onTapping),
        ),
      ),
    );
  }
}

class AddTodoForm extends ConsumerStatefulWidget {
  final VoidCallback onTapping;
  AddTodoForm(this.onTapping);

  @override
  _AddTodoFormState createState() => _AddTodoFormState();
}

class _AddTodoFormState extends ConsumerState<AddTodoForm> {
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
                        .createTodo(
                            _titleController.text, _descriptionController.text);
                    print('success: $success');
                    if (success) {
                      widget.onTapping();
                      Navigator.pop(context);
                      //context.pushNamed(AppRoute.home.name);
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

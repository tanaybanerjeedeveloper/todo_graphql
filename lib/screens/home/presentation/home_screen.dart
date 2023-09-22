import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_graphql_app/local_storage.dart';
import 'package:todo_graphql_app/screens/home/data/home_repository.dart';
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
  Widget build(BuildContext context) {
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
              _openForm(context);
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

  void _openForm(ctx) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        insetPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        // insetPadding: EdgeInsets.all(),
        child: SizedBox(
          width: 400,
          height: 400,
          child: AddTodoForm(),
        ),
      ),
    );
  }
}

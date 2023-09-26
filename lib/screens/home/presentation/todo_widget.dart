import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_graphql_app/screens/home/presentation/home_controller.dart';
import 'package:todo_graphql_app/screens/home/presentation/home_screen.dart';
import 'package:todo_graphql_app/widgets/updatetodo_form.dart';

class TodoWidget extends ConsumerStatefulWidget {
  final String title;
  final String description;
  final String id;
  final VoidCallback onTapBtn;

  TodoWidget({
    required this.description,
    required this.id,
    required this.title,
    required this.onTapBtn,
  });

  @override
  _TodoWidgetState createState() => _TodoWidgetState();
}

class _TodoWidgetState extends ConsumerState<TodoWidget> {
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
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Card(
            child: ListTile(
          leading: Text(widget.title),
          title: Text(widget.description),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () async {
                    _openForm(context, widget.onTapBtn, widget.id, widget.title,
                        widget.description);
                    // final success = await ref
                    //     .read(homeControllerProvider.notifier)
                    //     .updateTodo(
                    //         widget.id, widget.title, widget.description);
                    // print('success: $success');
                  },
                  icon: const Icon(Icons.edit)),
              IconButton(
                  onPressed: () async {
                    final success = await ref
                        .read(homeControllerProvider.notifier)
                        .deleteTodo(widget.id);
                    print('success: $success');
                    if (success) {
                      widget.onTapBtn();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Deleted Todo successfully'),
                        backgroundColor: Colors.deepPurple,
                        behavior: SnackBarBehavior.floating,
                      ));
                    }
                  },
                  icon: const Icon(Icons.delete))
            ],
          ),
        )),
      ),
    );
  }

  void _openForm(ctx, reload, String id, String title, String description) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        insetPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        // insetPadding: EdgeInsets.all(),
        child: SizedBox(
          width: 400,
          height: 400,
          child: UpdateTodoForm(
              onTapBtn: reload, description: description, id: id, title: title),
        ),
      ),
    );
  }
}

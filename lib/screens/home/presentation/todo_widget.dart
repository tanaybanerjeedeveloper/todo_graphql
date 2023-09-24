import 'package:flutter/material.dart';

class TodoWidget extends StatelessWidget {
  final String title;
  final String description;
  final String id;

  TodoWidget(
      {required this.description,
      required this.id,
      required this.title,
      required key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: mediaQuery.height * 0.01,
          horizontal: mediaQuery.width * 0.3),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Card(
            child: ListTile(
          leading: Text(title),
          title: Text(description),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
            ],
          ),
        )),
      ),
    );
  }
}

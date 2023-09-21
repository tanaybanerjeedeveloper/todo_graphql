import 'package:flutter/material.dart';

class TodoWidget extends StatelessWidget {
  final String title;
  final String description;
  final String id;

  TodoWidget(
      {required this.description, required this.id, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Card(child: Text(title)),
    );
  }
}

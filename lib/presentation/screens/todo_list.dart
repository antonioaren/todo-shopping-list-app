import 'package:flutter/material.dart';

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Text('Todo List'),
        Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter a new item',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Add'),
            ),
          ],
        ),
      ],
    );
  }
}

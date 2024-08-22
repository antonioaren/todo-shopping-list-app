import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/shopping_list.dart';

class TodoList extends StatefulWidget {
  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  late TextEditingController _textFieldController = TextEditingController();
  late FocusNode _myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _myFocusNode = FocusNode();
    _textFieldController = TextEditingController();
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    _myFocusNode.dispose();
    super.dispose();
  }

  void onAddItem() {
    final shoppingListState = Provider.of<ShoppingListState>(
      context,
      listen: false,
    );
    shoppingListState.addItem(_textFieldController.text);
    _textFieldController.clear();
    _myFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Text('Todo List',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.black, fontSize: 48)),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      focusNode: _myFocusNode,
                      controller: _textFieldController,
                      decoration: InputDecoration(
                        hintText: 'Enter a new item',
                      ),
                      onSubmitted: (String value) => onAddItem(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: onAddItem,
                    child: Text('Add'),
                  ),
                  Divider(),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Consumer<ShoppingListState>(
                      builder: (context, shoppingListState, child) {
                        final items = shoppingListState.getCurrent();

                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(items[index]),
                              trailing: IconButton(
                                icon: Icon(Icons.close,
                                    color: Colors.black, size: 24),
                                onPressed: () {
                                  shoppingListState.removeItem(index);
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

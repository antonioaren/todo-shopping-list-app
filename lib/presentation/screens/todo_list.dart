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
                            return Dismissible(
                              // Specify a key if the Slidable is dismissible.
                              key: ValueKey(items[index]),

                              onDismissed: (direction) {
                                shoppingListState.removeItem(index);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Item dismissed'),
                                  ),
                                );
                              },
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Delete',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CheckboxListTile(
                                  value: true,
                                  title: Text(items[index]),
                                  onChanged: (bool? value) {},
                                ),
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

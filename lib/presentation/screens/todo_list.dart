import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
                            return Slidable(
                              // Specify a key if the Slidable is dismissible.
                              key: const ValueKey(0),

                              // The start action pane is the one at the left or the top side.
                              startActionPane: ActionPane(
                                // A motion is a widget used to control how the pane animates.
                                motion: const ScrollMotion(),

                                // A pane can dismiss the Slidable.
                                dismissible:
                                    DismissiblePane(onDismissed: () {}),

                                // All actions are defined in the children parameter.
                                children: [
                                  // A SlidableAction can have an icon and/or a label.
                                  SlidableAction(
                                    onPressed: (BuildContext context) {
                                      shoppingListState.removeItem(index);
                                    },
                                    backgroundColor: Color(0xFFFE4A49),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  ),
                                ],
                              ),

                              // The child of the Slidable is what the user sees when the
                              // component is not dragged.
                              child: ListTile(title: Text(items[index])),
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

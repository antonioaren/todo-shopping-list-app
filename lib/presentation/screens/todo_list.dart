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
    final ShoppingListState shoppingListState = Provider.of<ShoppingListState>(
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
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      focusNode: _myFocusNode,
                      controller: _textFieldController,
                      decoration: InputDecoration(
                        hintText: 'Add new product',
                      ),
                      onSubmitted: (String value) => onAddItem(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: onAddItem,
                    child: Text('Add'),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  ContentList(),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class ContentList extends StatelessWidget {
  const ContentList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<ShoppingListState>(
        builder: (BuildContext context, ShoppingListState shoppingListState,
            Widget? child) {
          final List<ShoppingListItem> items = shoppingListState.getCurrent();

          return ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                // Specify a key if the Slidable is dismissible.
                key: ValueKey<int>(items[index].id),

                onDismissed: (DismissDirection direction) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${items[index].name} removed'),
                    ),
                  );
                  shoppingListState.removeItem(items[index].id);
                },

                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  child: DismissContent(),
                ),

                child: CheckboxContent(
                    items: items,
                    index: index,
                    shoppingListState: shoppingListState),
              );
            },
          );
        },
      ),
    );
  }
}

class DismissContent extends StatelessWidget {
  const DismissContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
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
    );
  }
}

class CheckboxContent extends StatelessWidget {
  const CheckboxContent({
    super.key,
    required this.items,
    required this.index,
    required this.shoppingListState,
  });

  final List<ShoppingListItem> items;
  final int index;
  final ShoppingListState shoppingListState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: CheckboxListTile(
        value: items[index].isDone,
        title: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 400),
          style: TextStyle(
            color: items[index].isDone ? Colors.grey : Colors.black,
            decoration: items[index].isDone
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
          child: Text(items[index].name),
        ),
        onChanged: (bool? value) {
          shoppingListState.toggleItem(items[index].id);
        },
      ),
    );
  }
}

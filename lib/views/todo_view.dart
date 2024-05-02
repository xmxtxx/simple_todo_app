import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_todo_app/logic/providers/todo_provider.dart';
import 'package:simple_todo_app/logic/todo.dart';

class TodoListPage extends ConsumerWidget {
  const TodoListPage({super.key});

  void _showEditDialog(BuildContext context, WidgetRef ref, Todo todo) {
    final TextEditingController _controller =
        TextEditingController(text: todo.description);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Todo'),
        content: TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: 'Edit todo description'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text('Save'),
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                ref
                    .read(todoProvider.notifier)
                    .editTodo(todo.id, _controller.text);
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  void _showAddDialog(BuildContext context, WidgetRef ref) {
    final TextEditingController _controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Todo'),
        content: TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: 'Enter todo description'),
          autofocus: true,
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              ref.read(todoProvider.notifier).addTodo(value);
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text('Add'),
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                ref.read(todoProvider.notifier).addTodo(_controller.text);
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Todo List')),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return ListTile(
            title: Text(todo.description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _showEditDialog(context, ref, todo),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () =>
                      ref.read(todoProvider.notifier).deleteTodo(todo.id),
                ),
              ],
            ),
            onTap: () =>
                ref.read(todoProvider.notifier).toggleTodoStatus(todo.id),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showAddDialog(context, ref),
      ),
    );
  }
}

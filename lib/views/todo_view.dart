import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_todo_app/logic/providers/todo_provider.dart';
import 'package:simple_todo_app/logic/providers/todo_view_provider.dart';
import 'package:simple_todo_app/view_model/todo_view_model.dart';
import 'package:simple_todo_app/views/widgets/todo_dialog_widget.dart';

class TodoListPage extends ConsumerWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoProvider);
    final viewModel = ref.watch(TodoViewProvider.toDoViewProvider);

    return switch (viewModel) {
      LoadingToDoViewModel() => const CircularProgressIndicator(),
      LoadedToDoViewModel() => Scaffold(
          appBar: AppBar(title: Text(viewModel.taskListTitle)),
          body: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return ListTile(
                leading: Checkbox(
                  value: todo.completed,
                  onChanged: (bool? newValue) {
                    ref.read(todoProvider.notifier).toggleTodoStatus(todo.id);
                  },
                ),
                title: Text(
                  todo.title,
                  style: TextStyle(
                    decoration: todo.completed
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    color: todo.completed ? Colors.grey : Colors.black,
                  ),
                ),
                subtitle: Text(
                  todo.description,
                  style: TextStyle(
                      color: todo.completed ? Colors.grey : Colors.black),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!todo.completed)
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) => TodoDialog(
                            ref: ref,
                            titleController:
                                TextEditingController(text: todo.title),
                            descriptionController:
                                TextEditingController(text: todo.description),
                            isEditing: true,
                            viewModel: viewModel,
                            todoId: todo.id,
                          ),
                        ),
                      ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () =>
                          ref.read(todoProvider.notifier).deleteTodo(todo.id),
                    ),
                  ],
                ),
                onTap: () => _showDescriptionDialog(
                    context, todo.title, todo.description, viewModel.cancel),
                tileColor:
                    todo.completed ? Colors.lightGreen[100] : Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => TodoDialog(
                ref: ref,
                titleController: TextEditingController(),
                descriptionController: TextEditingController(),
                isEditing: false,
                viewModel: viewModel,
              ),
            ),
          ),
        )
    };
  }

  void _showDescriptionDialog(
      BuildContext context, String title, String description, String cancel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Text(description),
        ),
        actions: [
          TextButton(
            child: Text(cancel),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

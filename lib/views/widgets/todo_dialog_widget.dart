import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_todo_app/logic/providers/todo_provider.dart';
import 'package:simple_todo_app/view_model/todo_view_model.dart';

class TodoDialog extends StatelessWidget {
  final WidgetRef ref;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final bool isEditing;
  final LoadedToDoViewModel viewModel;
  final String? todoId;

  const TodoDialog({
    super.key,
    required this.ref,
    required this.titleController,
    required this.descriptionController,
    required this.isEditing,
    required this.viewModel,
    this.todoId,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isEditing ? viewModel.editTodo : viewModel.addTodo),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: viewModel.enterTodoTitle),
            autofocus: true,
          ),
          TextField(
            controller: descriptionController,
            decoration:
                InputDecoration(hintText: viewModel.enterTodoDescription),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text(viewModel.cancel),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: Text(isEditing ? viewModel.save : viewModel.addTodo),
          onPressed: () {
            final title = titleController.text.trim();
            final description = descriptionController.text.trim();
            if (title.isNotEmpty) {
              if (isEditing && todoId != null) {
                ref
                    .read(todoProvider.notifier)
                    .editTodo(todoId!, title, description);
              } else {
                ref.read(todoProvider.notifier).addTodo(title, description);
              }
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_todo_app/logic/todo.dart';

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() : super([]);

  void addTodo(String description) {
    state = [
      ...state,
      Todo(id: DateTime.now().toString(), description: description)
    ];
  }

  void editTodo(String id, String newDescription) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
              id: todo.id,
              description: newDescription,
              completed: todo.completed)
        else
          todo,
    ];
  }

  void toggleTodoStatus(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
              id: todo.id,
              description: todo.description,
              completed: !todo.completed)
        else
          todo,
    ];
  }

  void deleteTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }
}

final todoProvider =
    StateNotifierProvider<TodoNotifier, List<Todo>>((ref) => TodoNotifier());

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_todo_app/logic/todo.dart';

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() : super([]);

  void addTodo(String title, String description) {
    final newTodo = Todo(
      id: DateTime.now().toString(),
      title: title,
      description: description,
      completed: false,
    );
    state = [...state, newTodo];
  }

  void editTodo(String id, String newTitle, String newDescription) {
    state = state.map((todo) {
      if (todo.id == id) {
        return Todo(
          id: todo.id,
          title: newTitle,
          description: newDescription,
          completed: todo.completed,
        );
      }
      return todo;
    }).toList();
  }

  void toggleTodoStatus(String id) {
    state = state.map((todo) {
      if (todo.id == id) {
        return Todo(
          id: todo.id,
          title: todo.title,
          description: todo.description,
          completed: !todo.completed,
        );
      }
      return todo;
    }).toList();
  }

  void deleteTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }
}

final todoProvider =
    StateNotifierProvider<TodoNotifier, List<Todo>>((ref) => TodoNotifier());

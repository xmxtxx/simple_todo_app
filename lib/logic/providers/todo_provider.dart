import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_todo_app/logic/todo.dart';

class TodoNotifier extends StateNotifier<List<Todo>> {
  static const String _todosKey = 'todos';

  TodoNotifier() : super([]) {
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final todosJson = prefs.getString(_todosKey);
      if (todosJson != null) {
        final List<dynamic> todosList = jsonDecode(todosJson);
        state = todosList.map((json) => Todo.fromJson(json)).toList();
      }
    } catch (e) {
      // If loading fails, keep empty state
    }
  }

  Future<void> _saveTodos() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final todosJson = jsonEncode(state.map((todo) => todo.toJson()).toList());
      await prefs.setString(_todosKey, todosJson);
    } catch (e) {
      // Silently fail if saving fails
    }
  }

  void addTodo(String title, String description) {
    final newTodo = Todo(
      id: DateTime.now().toString(),
      title: title,
      description: description,
      completed: false,
    );
    state = [...state, newTodo];
    _saveTodos();
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
    _saveTodos();
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
    _saveTodos();
  }

  void deleteTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
    _saveTodos();
  }
}

final todoProvider =
    StateNotifierProvider<TodoNotifier, List<Todo>>((ref) => TodoNotifier());

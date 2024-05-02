import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_todo_app/logic/providers/config_provider.dart';
import 'package:simple_todo_app/view_model/todo_view_model.dart';

mixin TodoViewProvider {
  static final toDoViewProvider = Provider<ToDoViewModel>((ref) {
    var config = ref.watch(ConfigProvider.configProvider);
    return config.maybeWhen(
        data: (value) => LoadedToDoViewModel(
            addTodo: value.addTodo,
            editTodo: value.editTodo,
            enterTodoTitle: value.enterTodoTitle,
            enterTodoDescription: value.enterTodoDescription,
            cancel: value.cancel,
            save: value.save,
            delete: value.delete,
            complete: value.complete,
            taskListTitle: value.taskListTitle),
        orElse: LoadingToDoViewModel.new);
  });
}
